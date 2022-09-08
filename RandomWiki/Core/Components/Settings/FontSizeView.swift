//
//  FontSizeView.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/7/22.
//

import SwiftUI

struct FontSizeView: View {
    @State private var fontToggle: Bool = false
    var body: some View {
        VStack {
            Divider()
            Toggle("Adjust to Scaled Font", isOn: $fontToggle)
                .padding()
            Divider()
            Spacer()
        }
    }
}

struct FontSizeView_Previews: PreviewProvider {
    static var previews: some View {
        FontSizeView()
    }
}
