import Foundation
import Capacitor
import AllowMeSDK
import AllowMeSDKHomolog

@objc(AllowMeCapacitorPlugin)
public class AllowMeCapacitorPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "AllowMeCapacitorPlugin"
    public let jsName = "AllowMeCapacitor"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "initialize", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "collect", returnType: CAPPluginReturnPromise)
    ]

    private let implementation = AllowMeCapacitor()

    @objc func initialize(_ call: CAPPluginCall) {
        guard let apiKey = call.getString("apiKey"), !apiKey.isEmpty else {
            call.reject("API Key is required.")
            return
        }

        // Lê o valor do ambiente passado ('hml' ou 'prod')
        let environment = call.getString("environment") ?? "prod"

        implementation.initialize(apiKey: apiKey, environment: environment) { result in
            switch result {
            case .success():
                call.resolve()
            case .failure(let error):
                call.reject("Initialization failed", error.localizedDescription, error)
            }
        }
    }

    @objc func collect(_ call: CAPPluginCall) {
        implementation.collect { result in
            switch result {
            case .success(let data):
                call.resolve([
                    "data": data
                ])
            case .failure(let error):
                call.reject("Collect failed", error.localizedDescription, error)
            }
        }
    }
}
