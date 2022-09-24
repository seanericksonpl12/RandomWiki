//
//  SettingsContentView.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/6/22.
//

import SwiftUI

struct SettingsContentView: View {
    // MARK: - Core Data
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: []) var favorites: FetchedResults<ArticleModel>
    
    // MARK: - In-App Purchasing
    @StateObject var store: StoreManager
    
    // MARK: - Stored Properties
    var selected: Bool
    
    // MARK: - View Inspector
    internal let inspection = Inspection<Self>()
    
    // MARK: - Main Content
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text("settings.title".localized)
                        .scaledFont(name: "montserrat", size: 16.0)
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 14, trailing: 20))
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                        .rotationEffect(.degrees(selected ? 90 : 0))
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 14, trailing: 20))
                }
                // MARK: - Dropdown Menu
                if selected {
                    VStack(spacing: 10) {
                        MenuItem<NotificationsView>(iconName: "bell.badge.fill",
                                                    iconColor: .yellow,
                                                    title: "notifications.title".localized,
                                                    destination: {NotificationsView()})
                        Divider().padding(.leading)
                        MenuItem<FontSizeView>(iconName: "textformat.size",
                                               iconColor: .blue,
                                               title: "font.size".localized,
                                               destination: {FontSizeView()})
                        Divider().padding(.leading)
                        MenuAlertItem(iconName: "trash.fill",
                                      iconColor: .gray,
                                      title: "settings.clear".localized,
                                      alertTitle: "settings.clearTitle".localized,
                                      alertAction: clearData)
                        Divider().padding(.leading)
                        MenuAlertItem(iconName: "dollarsign.circle.fill",
                                      iconColor: .green,
                                      title: "donation.title".localized,
                                      alertTitle: "donation.alert.title".localized,
                                      message: "donation.alert.message".localized,
                                      yesOption: "donation.alert.button".localized,
                                      alertAction: {store.buyProduct(product: store.myProduct)})
                        .padding(.bottom)
                    }
                }
            }
            Spacer()
        }
        .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
    
    func clearData() {
        for item in favorites {
            context.delete(item)
        }
        try? context.save()
    }
}
