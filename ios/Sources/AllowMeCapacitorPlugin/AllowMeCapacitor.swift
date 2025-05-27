import Foundation
import AllowMeSDK

public class AllowMeCapacitor: NSObject {
    private var allowMe: AllowMe?

    public func initialize(apiKey: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard allowMe == nil else {
            completion(.success(()))
            return
        }

        do {
            allowMe = try AllowMe.getInstance(withApiKey: apiKey)
        } catch {
            completion(.failure(error))
            return
        }

        allowMe?.setup(completion: { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        })
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

    // Chama `start()` antes de `collect()`
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
