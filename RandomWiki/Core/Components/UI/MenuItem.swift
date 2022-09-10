//
//  MenuItem.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/7/22.
//

import SwiftUI

struct MenuItem<Content: View>: View {
    
    // MARK: - Item Properties
    var iconName: String
    var iconColor: Color
    var title: String
    
    // MARK: - View Type
    @ViewBuilder let destination: Content
    
    // MARK: - Body
    var body: some View {
        NavigationLink(destination: destination.navigationBarTitleDisplayMode(.inline).navigationTitle("")) {
            HStack(spacing: 5) {
                Image(systemName: iconName)
                    .padding(.leading, 40)
                    .scaleEffect(0.75)
                    .foregroundColor(iconColor)
                Text(title)
                    .foregroundColor(.black)
                    .scaledFont(name: "Montserrat-Light", size: 14)
                Spacer()
                Image(systemName: "chevron.right")
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    .foregroundColor(.gray)
                    .scaleEffect(0.75)
            }
        }
    }
}

struct MenuItem_Previews: PreviewProvider {
    static var previews: some View {
        MenuItem<EmptyView>(iconName: "star.fill", iconColor: .yellow, title: "Favorites", destination: {EmptyView()})
    }
}
