import UIKit
import Flutter
import FirebaseCore
import FirebaseMessaging

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      application.registerForRemoteNotifications()

      if FirebaseApp.app() == nil {
                   FirebaseApp.configure()
               }
      
      
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      //Messaging.messaging().apnsToken = deviceToken
    }
}




