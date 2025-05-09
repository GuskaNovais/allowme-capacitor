import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(AllowMeCapacitorPlugin)
public class AllowMeCapacitorPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "AllowMeCapacitorPlugin"
    public let jsName = "AllowMeCapacitor"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "echo", returnType: CAPPluginReturnPromise)
    ]
    private let implementation = AllowMeCapacitor()

    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }
}
