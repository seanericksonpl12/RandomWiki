//
//  AppDelegate.swift
//  RandomWiki
//
//  Created by Sean Erickson on 8/26/22.
//

import Firebase
import UserNotifications
import SwiftUI
import Lottie

class AppDelegate: NSObject, UIApplicationDelegate {
    
    var didReload: Bool = false
    let gcmMessageIDKey = "gcm.message_id"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        LottieLogger.shared = .printToConsole
        Messaging.messaging().delegate = self
        
        UserDefaults.standard.register(defaults: [
            "fontSize" : 16,
            "scaledFontEnabled" : true,
            "notificationDate" : 1,
            "notificationsEnabled" : true,
            "reload" : false
        ])
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { response, error in
                if response {
                    NotificationHandler.main.setDailyRequest()
                }
            }
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound],
                                                                                  categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        NotificationCenter.default.post(.updateWebView)
        completionHandler(UIBackgroundFetchResult.newData)
    }
}


extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        let deviceToken: [String: String] = ["token":fcmToken ?? ""]
        print("Device token: ", deviceToken)
    }
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        NotificationCenter.default.post(.updateWebView)
        didReload = true
        print(userInfo)
        completionHandler([[.banner, .badge, .sound]])
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID from userNotificationCenter didReceive: \(messageID)")
        }
        if !didReload {
            NotificationCenter.default.post(.updateWebView)
        }
        didReload = false
        print(userInfo)
        
        completionHandler()
    }
}
