import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
       
    }

    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyAMUgyO17OnIHXmjCMpRksW1jLc2DORM9g")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
