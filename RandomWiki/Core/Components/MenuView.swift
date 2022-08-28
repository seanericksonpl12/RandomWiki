//
//  MenuView.swift
//  RandomWiki
//
//  Created by Sean Erickson on 8/28/22.
//

import SwiftUI

struct MenuView: View {
    let width: CGFloat
    let isOpen: Bool
    let menuClose: SimpleClosure
    
    var body: some View {
        ZStack {
        GeometryReader { _ in
            EmptyView()
        }
        .background(Color.gray.opacity(0.3))
        .opacity(self.isOpen ? 1.0 : 0.0)
        .onTapGesture {
            self.menuClose()
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
            .offset(x: self.isOpen ? 0 : -self.width)
            Spacer()
        }
        
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(width: 250, isOpen: true, menuClose: {})
    }
}
