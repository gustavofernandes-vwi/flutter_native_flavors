import Cocoa
import FlutterMacOS

public class FlutterNativeFlavorsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_native_flavors", binaryMessenger: registrar.messenger)
    let instance = FlutterNativeFlavorsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
    case "getFlavorName":
      var config: [String: Any]?

      if let infoPlistPath = Bundle.main.url(forResource: "Info", withExtension: "plist") {
          do {
              let infoPlistData = try Data(contentsOf: infoPlistPath)
              
              if let dict = try PropertyListSerialization.propertyList(from: infoPlistData, options: [], format: nil) as? [String: Any] {
                  config = dict
              }
          } catch {
              print(error)
          }
      }

      result(config?["App - Flavor"])
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
