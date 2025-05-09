import Foundation

@objc public class AllowMeCapacitor: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
}
