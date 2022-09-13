//
//  NotificationsView.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/7/22.
//

import SwiftUI

struct NotificationsView: View {
    
    // MARK: - Stored Properties
    var options: [NotificationOptions] = [.daily, .weekly]
    var day: [Int] = [1, 2, 3, 4, 5, 6, 7]
    
    // MARK: - State Properties
    @State var selectedDay: Int = UserDefaults.standard.getWeeklyNotification()
    @State var selectedOption: NotificationOptions = UserDefaults.standard.getNotificationOptions() ?? .daily
    @State var notificationsAllowed: Bool = UserDefaults.standard.notificationsEnabled()
    
    // MARK: - Body
    var body: some View {
        List {
            Toggle(isOn: $notificationsAllowed) {
                Text("notifications.allowed".localized)
                    .scaledFont(name: "Montserrat-Medium", size:  16)
            }
            .onChange(of: notificationsAllowed) { value in
                UserDefaults.standard.setNotificationsEnabled(to: value)
            }
            // MARK: - Notification Selection
            if notificationsAllowed {
                Section {
                    Picker(selection: $selectedOption) {
                        ForEach(options, id: \.self) {
                            Text($0.rawValue.capitalized)
                                .scaledFont(name: "Montserrat-Medium", size:  16)
                        }
                    } label: {
                        Text("notifications.title".localized)
                            .scaledFont(name: "Montserrat-Medium", size:  16)
                    }
                    .onChange(of: selectedOption) { value in
                        UserDefaults.standard.setNotifications(to: value)
                    }
                    if selectedOption == .weekly {
                        Picker(selection: $selectedDay) {
                            ForEach(day, id: \.self) {
                                Text("day.\(String($0))".localized)
                                    .scaledFont(name: "Montserrat-Medium", size:  16)
                            }
                        } label: {
                            Text("day.dayOfWeek".localized)
                                .scaledFont(name: "Montserrat-Medium", size:  16)
                        }
                        .onChange(of: selectedDay) { day in
                            UserDefaults.standard.setWeeklyNotification(to: day)
                        }
                    }
                }
            }
        }
        .onAppear() {
            self.selectedDay = UserDefaults.standard.getWeeklyNotification()
            self.selectedOption = UserDefaults.standard.getNotificationOptions() ?? .daily
            self.notificationsAllowed = UserDefaults.standard.notificationsEnabled()
        }
        .animation(.easeIn, value: selectedOption == .weekly)
        .animation(.easeIn, value: notificationsAllowed)
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
