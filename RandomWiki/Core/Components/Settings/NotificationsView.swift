//
//  NotificationsView.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/7/22.
//

import SwiftUI

struct NotificationsView: View {
    
    // MARK: - Stored Properties
    var options: [NotificationOptions] = [.daily, .weekly, .disabled]
    var day: [Int] = [1, 2, 3, 4, 5, 6, 7]
    // MARK: - State Properties
    @State var selectedDay: Int = UserDefaults.standard.getWeeklyNotification()
    @State var selectedOption: NotificationOptions = UserDefaults.standard.getNotificationOptions() ?? .daily
    @State var notificationsAllowed: Bool = UserDefaults.standard.getNotificationOptions() == .disabled
    
    // MARK: - Body
    var body: some View {
        
        List {
            Toggle(isOn: $notificationsAllowed, label: {Text("Notifications Allowed:")})
            
            if notificationsAllowed {
                Section {
                    Picker("Notifications", selection: $selectedOption) {
                        ForEach(options, id: \.self) {
                            Text($0.rawValue.capitalized)
                        }
                    }
                    .onChange(of: selectedOption) { value in
                        UserDefaults.standard.setNotifications(to: value)
                    }
                    
                    if selectedOption == .weekly {
                        Picker("Day of the Week:", selection: $selectedDay) {
                            ForEach(day, id: \.self) {
                                Text(dayOfTheWeek($0) ?? "")
                            }
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
        }
        .animation(.easeIn, value: selectedOption == .weekly)
        .animation(.easeIn, value: notificationsAllowed)
    }
    
    func dayOfTheWeek(_ int: Int) -> String? {
        switch int {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return nil
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
