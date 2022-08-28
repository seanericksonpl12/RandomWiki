//
//  NavigationBar.swift
//  RandomWiki
//
//  Created by Sean Erickson on 8/27/22.
//

import SwiftUI

struct NavigationBar: View {
    // MARK: - Actions
    var savedAction: SimpleClosure = {}
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                savedAction()
            } label: {
                HStack {
                    Text("Saved")
                        .foregroundColor(.gray)
                    Image(systemName: "square.and.arrow.down")
                }
            }
            .padding()
        }
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
            .previewLayout(.fixed(width: 500, height: 50))
    }
}
