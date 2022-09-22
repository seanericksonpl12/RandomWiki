//
//  NotificationsViewModel.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/22/22.
//

import SwiftUI

extension NotificationsView {
    @MainActor class NotificationsViewModel: ObservableObject {
        @Published var selectedOption: NotificationOptions = UserDefaults.standard.getNotificationOptions() ?? .daily
        @Published var notificationsAllowed: Bool = UserDefaults.standard.notificationsEnabled()
        @Published var selectedDay: Int = UserDefaults.standard.getWeeklyNotification()
        
        func update() {
            // set notifications correspondingly
            UserDefaults.standard.setNotificationsEnabled(to: notificationsAllowed)
            UserDefaults.standard.setNotifications(to: selectedOption)
            UserDefaults.standard.setWeeklyNotification(to: selectedDay)
            
            if !notificationsAllowed {
                NotificationHandler.main.disable()
                return
            }
            if selectedOption == .daily {
                NotificationHandler.main.setDailyRequest()
                return
            }
            if selectedOption == .weekly {
                NotificationHandler.main.setWeekly(day: selectedDay)
            }
        }
    }
}
