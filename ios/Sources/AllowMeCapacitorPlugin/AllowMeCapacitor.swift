import Foundation
import AllowMeSDK
import AllowMeSDKHomolog

public class AllowMeCapacitor: NSObject {
    private var allowMe: AllowMeSDK.AllowMe? // evitar ambiguidade
    private var useHomolog: Bool = false
    
public func initialize(apiKey: String, environment: String, completion: @escaping (Result<Void, Error>) -> Void) {
    guard allowMe == nil else {
        completion(.success(()))
        return
    }

    useHomolog = environment.lowercased() == "hml"

    do {
        let instance = try (useHomolog
            ? AllowMeSDKHomolog.AllowMe.getInstance(withApiKey: apiKey)
            : AllowMeSDK.AllowMe.getInstance(withApiKey: apiKey)
        )

        guard let typedInstance = instance as? AllowMeSDK.AllowMe else {
            completion(.failure(NSError(
                domain: "AllowMeCapacitor",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Invalid SDK instance type"]
            )))
            return
        }

        self.allowMe = typedInstance

        typedInstance.setup { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    } catch {
        completion(.failure(error))
    }
}

    public func collect(completion: @escaping (Result<String, Error>) -> Void) {
        guard let allowMe = allowMe else {
            completion(.failure(NSError(
                domain: "AllowMeCapacitor",
                code: 0,
                userInfo: [NSLocalizedDescriptionKey: "SDK not initialized"]
            )))
            return
        }

        if let startError = allowMe.start() {
            print("[AllowMeSDK] Start error: \(startError.localizedDescription)")
            completion(.failure(startError))
            return
        }

        allowMe.collect(
            onSuccess: { data in
                print("[AllowMeSDK] Collect successful")
                completion(.success(data))
            },
            onError: { error in
                print("[AllowMeSDK] Collect error: \(error?.localizedDescription ?? "Unknown error")")
                completion(.failure(error ?? NSError(
                    domain: "AllowMeCapacitor",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "Unknown error from collect"]
                )))
            }
        )
    }
}
