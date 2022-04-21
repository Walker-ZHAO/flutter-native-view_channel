import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    static let VIEW_TYPE_NATIVE = "walker.demo/native_view"
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        weak var registrar = self.registrar(forPlugin: AppDelegate.VIEW_TYPE_NATIVE)
        let factory = NativeViewFactory(messenger: registrar!.messenger())
        registrar?.register(factory, withId: AppDelegate.VIEW_TYPE_NATIVE)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
