//
//  MediumWidgetView.swift
//  Random Wiki WidgetExtension
//
//  Created by Sean Erickson on 10/4/22.
//

import WidgetKit
import SwiftUI

struct MediumWidgetView: View {
    var entry: SimpleEntry
    
    var body: some View {
        GroupBox {
            GroupBox {
                HStack {
                    Image(systemName: "globe.americas")
                        .foregroundColor(.green)
                        .padding(EdgeInsets(top: -5, leading: 0, bottom: -5, trailing: 0))
                    Text(entry.title)
                        .padding(EdgeInsets(top: -5, leading: 0, bottom: -5, trailing: 0))
                    Spacer()
                }
                .padding(EdgeInsets(top: -5, leading: 0, bottom: -5, trailing: 0))
            }
            .padding(EdgeInsets(top: -5, leading: 0, bottom: 0, trailing: 0))
            Text(entry.description)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: -5, trailing: 0))
                .frame(maxHeight: .infinity)
        }
        .ignoresSafeArea()
    }
}
