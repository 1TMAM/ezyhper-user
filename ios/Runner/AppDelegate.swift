import UIKit
import Flutter
import Firebase
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    FirebaseApp.configure()
     GMSServices.provideAPIKey("AIzaSyA19oV9fN9IDDaVpWJ4MJETCjG7QKpG9hE")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
