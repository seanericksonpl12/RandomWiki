//
//  SettingsContentView.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/6/22.
//

import SwiftUI

struct SettingsContentView: View {
    var selected: Bool
    var clearData: SimpleClosure
    // MARK: - Body
    var body: some View {
        HStack {
            content
            Spacer()
        }
    }
    
    // MARK: - Main Content
    var content: some View {
        VStack {
            HStack {
                Text("Settings")
                    .foregroundColor(.black)
                    .scaledFont(name: "montserrat", size: 16.0)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 4, trailing: 20))
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .rotationEffect(.degrees(selected ? 90 : 0))
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 4, trailing: 20))
            }
            if selected {
                VStack(spacing: 5) {
                    // TODO: - New custom view for each settings tab
                    MenuItem<EmptyView>(iconName: "bell.badge.fill", iconColor: .yellow, title: "Notifications", destination: {EmptyView()})
                    MenuItem<FontSizeView>(iconName: "textformat.size", iconColor: .blue, title: "Font Size", destination: {FontSizeView()})
                    MenuAlertItem(iconName: "trash.fill", iconColor: .gray, title: "Clear Data", alertTitle: "Clear All Data?", alertAction: clearData)
                    MenuItem<EmptyView>(iconName: "bell.badge.fill", iconColor: .gray, title: "Donations :)", destination: {EmptyView()})
                }
            }
            Divider()
        }
    }
}

//struct SettingsContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsContentView()
//    }
//}
