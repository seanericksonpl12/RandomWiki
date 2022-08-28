//
//  SettingsView.swift
//  RandomWiki
//
//  Created by Sean Erickson on 8/28/22.
//

import SwiftUI

struct SettingsView: View {
    let width: CGFloat
    let isOpen: Bool
    let settingClose: SimpleClosure
    
    var body: some View {
        ZStack {
        GeometryReader { _ in
            EmptyView()
        }
        .background(Color.gray.opacity(0.3))
        .opacity(self.isOpen ? 1.0 : 0.0)
        .onTapGesture {
            self.settingClose()
        }
        HStack {
            List {
                Text("My Profile").onTapGesture {
                    print("My Profile")
                }
                Text("Posts").onTapGesture {
                    print("Posts")
                }
                Text("Logout").onTapGesture {
                    print("Logout")
                }
            }
            .frame(width: self.width)
            .background(Color.white)
            .offset(x: self.isOpen ? UIScreen.main.bounds.size.width - self.width : UIScreen.main.bounds.size.width)
            Spacer()
        }
        
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(width: 300, isOpen: true, settingClose: {})
    }
}
