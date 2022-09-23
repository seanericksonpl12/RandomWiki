//
//  NotificationHandler.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/22/22.
//

import NotificationCenter

class NotificationHandler {
    private init(){}
    static let main = NotificationHandler()
    
    func setDailyRequest() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        content.title = "notifications.header.daily".localized
        content.body = "notifications.body".localized
        var components = DateComponents()
        components.hour = 10
        components.minute = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let uuid = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { error in
            if let error = error { print(error.localizedDescription) }
        }
    }
    
    func setWeekly(day: Int) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        content.title = "notifications.header.weekly".localized
        content.body = "notifications.body".localized
        var components = DateComponents()
        components.calendar = Calendar.current
        components.hour = 10
        components.minute = 0
        components.day = day
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let uuid = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { error in
            if let error = error { print(error.localizedDescription) }
        }
    }
    
    func disable() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
