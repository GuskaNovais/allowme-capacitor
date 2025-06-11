import Foundation
import AllowMeSDK
import AllowMeSDKHomolog

// Protocolo com os métodos comuns necessários
protocol AllowMeProtocol {
    func setup(completion: @escaping (Error?) -> Void)
    func collect(onSuccess: @escaping (String) -> Void, onError: @escaping (Error?) -> Void)
}


class AllowMeProdAdapter: AllowMeProtocol {
    private let allowMeInstance: AllowMeSDK.AllowMe

    init?(apiKey: String) {
        guard let instance = try? AllowMeSDK.AllowMe.getInstance(withApiKey: apiKey) else {
            return nil
        }
        self.allowMeInstance = instance
    }

    func setup(completion: @escaping (Error?) -> Void) {
        allowMeInstance.setup { error in
            completion(error)
        }
    }

    func collect(onSuccess: @escaping (String) -> Void, onError: @escaping (Error?) -> Void) {
        allowMeInstance.collect(onSuccess: onSuccess, onError: onError)
    }
}

class AllowMeHmlAdapter: AllowMeProtocol {
    private let allowMeInstance: AllowMeSDKHomolog.AllowMe

    init?(apiKey: String) {
        guard let instance = try? AllowMeSDKHomolog.AllowMe.getInstance(withApiKey: apiKey) else {
            return nil
        }
        self.allowMeInstance = instance
    }

    func setup(completion: @escaping (Error?) -> Void) {
        allowMeInstance.setup { error in
            completion(error)
        }
    }

    func collect(onSuccess: @escaping (String) -> Void, onError: @escaping (Error?) -> Void) {
        allowMeInstance.collect(onSuccess: onSuccess, onError: onError)
    }
}

public class AllowMeCapacitor: NSObject {
    private var allowMe: AllowMeProtocol?

    public func initialize(apiKey: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard allowMe == nil else {
            completion(.success(()))
            return
        }

        if let prod = AllowMeProdAdapter(apiKey: apiKey) {
            prod.setup { [weak self] error in
                if let error = error {
                    print("[AllowMeCapacitor] SDK Produção falhou no setup: \(error). Tentando homologação...")
                    self?.initializeHomolog(apiKey: apiKey, completion: completion)
                } else {
                    self?.allowMe = prod
                    completion(.success(()))
                }
            }
        } else {
            print("[AllowMeCapacitor] Falha ao criar instância do SDK Produção. Tentando homologação...")
            initializeHomolog(apiKey: apiKey, completion: completion)
        }
    }

    private func initializeHomolog(apiKey: String, completion: @escaping (Result<Void, Error>) -> Void) {
        if let hml = AllowMeHmlAdapter(apiKey: apiKey) {
            hml.setup { [weak self] error in
                if let error = error {
                    print("[AllowMeCapacitor] SDK Homolog falhou no setup: \(error)")
                    completion(.failure(error))
                } else {
                    self?.allowMe = hml
                    completion(.success(()))
                }
            }
        } else {
            let error = NSError(domain: "AllowMeCapacitor", code: 2,
                                userInfo: [NSLocalizedDescriptionKey: "Falha ao criar instância do SDK Homolog"])
            print("[AllowMeCapacitor] \(error.localizedDescription)")
            completion(.failure(error))
        }
    }

    public func collect(completion: @escaping (Result<String, Error>) -> Void) {
        guard let allowMe = allowMe else {
            completion(.failure(NSError(domain: "AllowMeCapacitor", code: 0,
                                        userInfo: [NSLocalizedDescriptionKey: "SDK not initialized"])))
            return
        }

        allowMe.collect(
            onSuccess: { data in
                print("[AllowMeCapacitor] Collect successful")
                completion(.success(data))
            },
            onError: { error in
                print("[AllowMeCapacitor] Collect error: \(error?.localizedDescription ?? "Unknown error")")
                completion(.failure(error ?? NSError(domain: "AllowMeCapacitor", code: -1,
                                                    userInfo: [NSLocalizedDescriptionKey: "Unknown error from collect"])))
            }
        )
    }
}