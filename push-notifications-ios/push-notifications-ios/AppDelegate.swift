import UIKit
import BeamsChatkit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let pushNotifications = PushNotifications.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let tokenProvider = BeamsTokenProvider(authURL: "YOUR-TOKEN-PROVIDER-URL") { () -> AuthData in
            let sessionToken = "SESSION-TOKEN"
            return AuthData(headers: ["Authorization": "Bearer \(sessionToken)"], urlParams: [:])
        }

        self.pushNotifications.start(instanceId: "YOUR_INSTANCE_ID", beamsTokenProvider: tokenProvider) // Can be found here: https://dash.pusher.com
        try? self.pushNotifications.setUserId("Johnny Cash", completion: { (error) in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
        })
        self.pushNotifications.registerForRemoteNotifications()
        try? self.pushNotifications.subscribe(interest: "hello")

        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        self.pushNotifications.registerDeviceToken(deviceToken)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        self.pushNotifications.handleNotification(userInfo: userInfo)
        print(userInfo)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Remote notification support is unavailable due to error: \(error.localizedDescription)")
    }
}
