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
import WidgetKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    let gcmMessageIDKey = "gcm.message_id"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        LottieLogger.shared = .printToConsole
        Messaging.messaging().delegate = self
        setUserDefaults()
        
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
        setNotificationActions()
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
        if response.actionIdentifier == "open" {
            NotificationCenter.default.post(.updateWebView)
        }
        else if response.actionIdentifier == "read" {
            NotificationCenter.default.post(.readText)
        }
        
        print(userInfo)
        completionHandler()
    }
}

// MARK: - Initial Setup
extension AppDelegate {
    
    func setUserDefaults() {
        var data: Data = Data()
        let encoder = JSONEncoder()
        do {
            data = try encoder.encode(NotificationOptions.daily)
        } catch { print(error.localizedDescription) }
        
        UserDefaults.standard.register(defaults: [
            "fontSize" : 16,
            "scaledFontEnabled" : true,
            "notificationDate" : 1,
            "notificationsEnabled" : true,
            "notificationSettings" : data
        ])
        
        if let ud = UserDefaults(suiteName: "group.com.RandomWikiWidget") {
            ud.set("...", forKey: "articleTitle")
            ud.set("...", forKey: "articleDescription")
        }
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func setNotificationActions() {
        let openAppAction = UNNotificationAction(identifier: "open", title: "Open in app", options: [.foreground])
        let readDescription = UNNotificationAction(identifier: "read", title: "Play Reader")
        let category = UNNotificationCategory(identifier: "notifications.local", actions: [openAppAction, readDescription], intentIdentifiers: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
}
