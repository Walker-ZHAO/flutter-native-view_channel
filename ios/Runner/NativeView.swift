//
//  NativeView.swift
//  Runner
//
//  Created by Walker Zhao on 2022/4/21.
//

import Foundation
import Flutter

class NativeView: NSObject, FlutterPlatformView {
    
    static let CHANNEL_NAME_PREFIX = "walker.flutter.view_channel"
    static let METHOD_NAME_SendToNative = "sendToNative"
    static let METHOD_NAME_ReceiveFromNative = "receiveFromNative"
    static let METHOD_PARAM_MESSAGE = "message"
    
    private let magicView: MagicView
    private let methodChannel: FlutterMethodChannel
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
        magicView = MagicView(frame: frame)
        methodChannel = FlutterMethodChannel(name: "\(NativeView.CHANNEL_NAME_PREFIX)/\(viewId)", binaryMessenger: messenger)
        super.init()
        magicView.onSendButtonClick = sendMessage
        methodChannel.setMethodCallHandler {
            [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            switch call.method {
            case NativeView.METHOD_NAME_SendToNative:
                let args = call.arguments as? [String: Any]
                let text = args?[NativeView.METHOD_PARAM_MESSAGE] as? String ?? ""
                self?.magicView.receiveMessage(message: text)
                result(0)
            default:
                result(FlutterMethodNotImplemented)
                
            }
        }
    }
    
    func view() -> UIView {
        return magicView
    }
    
    private func sendMessage(message: String) {
        methodChannel.invokeMethod(
            NativeView.METHOD_NAME_ReceiveFromNative,
            arguments: [NativeView.METHOD_PARAM_MESSAGE: message]) { (result) in
                let sendResult = "send to flutter result: \(result ?? "nil")"
                print(sendResult)
            }
    }
}
