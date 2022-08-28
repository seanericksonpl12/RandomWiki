//
//  NavigationBar.swift
//  RandomWiki
//
//  Created by Sean Erickson on 8/27/22.
//

import SwiftUI

struct NavigationBar: View {
    // MARK: - Actions
    var menuAction: SimpleClosure = {}
    var settingsAction: SimpleClosure = {}
    
    var body: some View {
        HStack {
            Button {
                menuAction()
            } label: {
                Image(systemName: "slider.horizontal.3")
                    .foregroundColor(.gray)
            }
            .padding()
            Spacer()
            Button {
                settingsAction()
            } label: {
                Image(systemName: "gearshape")
                    .foregroundColor(.gray)
            }
            .padding()
        }
    }
}

// MARK: - Preview
struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
            .previewLayout(.fixed(width: 500, height: 50))
    }
}
