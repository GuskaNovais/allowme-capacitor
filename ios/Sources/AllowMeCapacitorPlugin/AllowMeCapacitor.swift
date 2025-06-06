import Foundation
#if DEBUG
import AllowMeSDKHomolog
#else
import AllowMeSDK
#endif

public class AllowMeCapacitor: NSObject {
    private var allowMe: AllowMe?
    
public func initialize(apiKey: String, completion: @escaping (Result<Void, Error>) -> Void) {
    guard allowMe == nil else {
        completion(.success(()))
        return
    } 

    do {
        self.allowMe = try AllowMe.getInstance(withApiKey: apiKey)

        self.allowMe?.setup { error in
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