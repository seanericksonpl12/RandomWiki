//
//  UserDefaultsExtensions.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/4/22.
//

import Foundation
import SwiftUI
import WebKit

// MARK: - Favorites List
//extension UserDefaults {
//
//    func saveArticles(_ articles: [Article]) {
//        var data: [Data] = []
//        for article in articles {
//            if let json = article.toJSON() { data.append(json) }
//        }
//        set(data, forKey: "favorites")
//    }
//
//    func loadArticles() -> [Article]? {
//        var articles: [Article] = []
//        guard let data = array(forKey: "favorites") as? [Data] else { return nil }
//        let decoder = JSONDecoder()
//        for datum in data {
//            do {
//                let decoded = try decoder.decode(Article.self, from: datum)
//                articles.append(decoded)
//            } catch {
//                print(error)
//                continue
//            }
//        }
//        return articles
//    }
//
//    func clear() {
//        removeObject(forKey: "favorites")
//    }
//}

// MARK: - Current Article ID
extension UserDefaults {
    
    func setCurrentID(to id: UUID) {
        set(id.uuidString, forKey: "currentID")
    }
    
    func getCurrentID() -> UUID? {
        if let id = string(forKey: "currentID") {
            return UUID(uuidString: id)
        }
        return nil
    }
}

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
    
    func setFontSize(_ size: Float) {
        set(size, forKey: "customFontSize")
    }
    
    func fontSize() -> Float {
        return float(forKey: "customFontSize")
    }
}

// MARK: - Notifications
extension UserDefaults {
    
    func shouldRecieveNotification() -> Bool {
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
            case .disabled:
                return false
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
}
