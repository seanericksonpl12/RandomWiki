//
//  LargeWidgetView.swift
//  Random Wiki WidgetExtension
//
//  Created by Sean Erickson on 10/4/22.
//

import WidgetKit
import SwiftUI

struct LargeWidgetView: View {
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
            
            if let img = entry.image {
                if !entry.horizontal {
                    HStack(alignment: .top) {
                        img
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(5)
                        GeometryReader { geo in
                            CustomTextView(text: entry.description, layoutFrame: geo.frame(in: .local).insetBy(dx: -50, dy: -50))
                        }
                        //CustomTextView(text: entry.description, layoutFrame: entry.imageFrame!)
                    }
                } else {
                    VStack {
                        //CustomTextView(text: entry.description, layoutFrame: entry.imageFrame!)
                        GeometryReader { geo in
                            CustomTextView(text: entry.description, layoutFrame: geo.frame(in: .local).insetBy(dx: -50, dy: -50))
                        }
                        img
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(5)
                    }
                }
            } else {
                Text(entry.description)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: -5, trailing: 0))
                    .frame(maxHeight: .infinity)
            }
        }
        .onAppear {
            print(entry.imageFrame)
        }
        .ignoresSafeArea()
    }
}
