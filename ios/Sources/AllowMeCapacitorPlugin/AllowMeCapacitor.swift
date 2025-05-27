import Foundation

@objc public class AllowMeCapacitor: NSObject {
    private var allowMe: AllowMe?

    @objc public func initialize(apiKey: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard allowMe == nil else {
            completion(.success(()))
            return
        }

        allowMe = AllowMe(apiKey: apiKey)
        allowMe?.setup(success: {
            completion(.success(()))
        }, failure: { error in
            completion(.failure(error))
        })
    }

    @objc public func collect(completion: @escaping (Result<String, Error>) -> Void) {
        guard let allowMe = allowMe else {
            completion(.failure(NSError(domain: "AllowMeCapacitor", code: 0, userInfo: [NSLocalizedDescriptionKey: "SDK not initialized"])))
            return
        }

        allowMe.collect(success: { data in
            completion(.success(data))
        }, failure: { error in
            completion(.failure(error))
        })
    }
}
