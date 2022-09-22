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
    
    // MARK: - Dependency
    @StateObject var viewModel: NotificationsViewModel = NotificationsViewModel()
    
    // MARK: - Testing
    internal let inspection = Inspection<Self>()
    
    // MARK: - Body
    var body: some View {
        List {
            Toggle(isOn: $viewModel.notificationsAllowed) {
                Text("notifications.allowed".localized)
                    .scaledFont(name: "Montserrat-Medium", size:  16)
            }
            .onChange(of: viewModel.notificationsAllowed) { val in
                viewModel.update()
            }
            // MARK: - Notification Selection
            if viewModel.notificationsAllowed {
                Section {
                    Picker(selection: $viewModel.selectedOption) {
                        ForEach(options, id: \.self) {
                            Text($0.rawValue.capitalized)
                                .scaledFont(name: "Montserrat-Medium", size:  16)
                        }
                    } label: {
                        Text("notifications.title".localized)
                            .scaledFont(name: "Montserrat-Medium", size:  16)
                    }
                    .onChange(of: viewModel.selectedOption) { _ in
                        viewModel.update()
                    }
                    if viewModel.selectedOption == .weekly {
                        Picker(selection: $viewModel.selectedDay) {
                            ForEach(day, id: \.self) {
                                Text("day.\(String($0))".localized)
                                    .scaledFont(name: "Montserrat-Medium", size:  16)
                            }
                        } label: {
                            Text("day.dayOfWeek".localized)
                                .scaledFont(name: "Montserrat-Medium", size:  16)
                        }
                        .onChange(of: viewModel.selectedDay) { _ in
                            viewModel.update()
                        }
                    }
                }
            }
        }
        .animation(.easeIn, value: viewModel.selectedOption == .weekly)
        .animation(.easeIn, value: viewModel.notificationsAllowed)
        .navigationTitle("Notifications")
        .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
