//
//  DropDownView.swift
//  RandomWiki
//
//  Created by Sean Erickson on 8/30/22.
//

import SwiftUI

struct DropDownView: View {
    var selected: Bool
    var dropDown: DropDown
    
    var body: some View {
        HStack {
            content
            Spacer()
        }
    }
    
    var content: some View {
        VStack {
            HStack {
                Text(dropDown.label)
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
                ForEach(dropDown.children) { child in
                    NavigationLink(destination: EmptyView()) {
                        Text(child.label)
                    }
                }
            }
            
            
            Divider()
            
        }
    }
}

struct DropDown: Identifiable, Hashable {
    var id: Int
    var label: String
    var children: [DropDown]
}

//struct DropDownView_Previews: PreviewProvider {
//    static var previews: some View {
//        DropDownView(selected: false)
//    }
//}
