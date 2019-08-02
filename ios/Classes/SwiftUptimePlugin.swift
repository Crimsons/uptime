import Flutter
import UIKit
import Foundation

public class SwiftUptimePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "uptime", binaryMessenger: registrar.messenger())
    let instance = SwiftUptimePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result(Int(ProcessInfo.processInfo.systemUptime * 1000))
  }
}
