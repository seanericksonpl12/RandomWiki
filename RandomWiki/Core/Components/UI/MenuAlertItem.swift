//
//  MenuAlertItem.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/7/22.
//

import SwiftUI

struct MenuAlertItem: View {
    
    // MARK: - Item Properties
    var iconName: String
    var iconColor: Color
    var title: String
    var alertTitle: String
    var message: String?
    var yesOption: String = "yes.upper".localized
    var alertAction: SimpleClosure
    
    // MARK: - State Properties
    @State private var alert: Bool = false
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: iconName)
                .padding(.leading, 40)
                .scaleEffect(0.75)
                .foregroundColor(iconColor)
            Text(title)
                .foregroundColor(Color("Text"))
                .scaledFont(name: "Montserrat-Light", size: 14)
            Spacer()
            Image(systemName: "chevron.right")
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                .foregroundColor(.gray)
                .scaleEffect(0.75)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            alert = true
        }
        .alert(alertTitle, isPresented: $alert){
            Button(yesOption, role: .destructive){ alertAction() }
        }
        message: {
            if let message = message {
                Text(message)
            }
        }
        
        
    }
}

struct MenuAlertItem_Previews: PreviewProvider {
    static var previews: some View {
        MenuAlertItem(iconName: "", iconColor: .blue, title: "", alertTitle: "", alertAction: {})
    }
}
