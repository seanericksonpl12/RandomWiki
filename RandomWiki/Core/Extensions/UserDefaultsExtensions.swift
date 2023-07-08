//
//  UserDefaultsExtensions.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/4/22.
//

import Foundation
import SwiftUI
import WebKit

// MARK: - Scaled Font
extension UserDefaults {
    
    func setScaledFontEnabled(_ enabled: Bool) {
        set(enabled, forKey: "scaledFontEnabled")
    }
    
    func scaledFontEnabled() -> Bool {
        return bool(forKey: "scaledFontEnabled")
    }
}

// MARK: - Custom Font Size
extension UserDefaults {
    
    func setFontSize(_ size: Double) {
        set(size, forKey: "customFontSize")
    }
    
    func fontSize() -> Double {
        return double(forKey: "customFontSize")
    }
}

// MARK: - Notifications
extension UserDefaults {
    
    func shouldRecieveNotification() -> Bool {
        if !notificationsEnabled() { return false }
        guard let settings = getNotificationOptions() else { return true }
        switch settings {
        case .daily:
            return true
        case .weekly:
            let day = integer(forKey: "notificationDate")
            guard let today = Calendar.current.dateComponents([.weekday], from: Date()).weekday else { return false }
            if day == today {
                return true
            } else { return false }
        }
    }
    
    func setWeeklyNotification(to date: Int) {
        set(date, forKey: "notificationDate")
    }
    
    func getWeeklyNotification() -> Int {
        return integer(forKey: "notificationDate")
    }
    
    func setNotifications(to notification: NotificationOptions) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(notification)
            set(data, forKey: "notificationSettings")
        } catch { print(error) }
    }
    
    func getNotificationOptions() -> NotificationOptions? {
        guard let data = data(forKey: "notificationSettings") else { return nil }
        
        do {
            let decoder = JSONDecoder()
            let settings = try decoder.decode(NotificationOptions.self, from: data)
            return settings
        } catch { print(error)
            return nil }
    }
    
    func setNotificationsEnabled(to val: Bool) {
        set(val, forKey: "notificationsEnabled")
    }
    
    func notificationsEnabled() -> Bool {
        return bool(forKey: "notificationsEnabled")
    }
}

extension UserDefaults {
    
    func setCurrentUUID(_ id: UUID) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(id)
            set(data, forKey: "currentArticleId")
        } catch { print(error) }
    }
    
    func currentUUID() -> UUID? {
        guard let data = data(forKey: "currentArticleId") else { return nil }
        
        do {
            let decoder = JSONDecoder()
            let id = try decoder.decode(UUID.self, from: data)
            return id
        } catch {
            print(error)
            return nil
        }
    }
    
    func setCurrentURL(_ to: URL?) {
        set(to, forKey: "url")
    }
    
    func currentURL() -> URL {
        return url(forKey: "url") ?? URL(string: "https://en.wikipedia.org/wiki/Special:Random")!
    }
}

// MARK: - Widget
extension UserDefaults {
    
    func setWidgetInfo(to: Float) {
        if let ud = UserDefaults(suiteName: "group.com.RandomWikiWidget") {
            ud.set(to, forKey: "widgetFloat")
        }
    }
}
