//
//  FontSizeView.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/7/22.
//

import SwiftUI

struct FontSizeView: View {
    @State private var fontToggle: Bool = UserDefaults.standard.scaledFontEnabled()
    @State private var fontSize: Float = UserDefaults.standard.fontSize()
    var body: some View {
        List {
            Toggle(isOn: $fontToggle) {
                Text("font.adjust".localized)
                    .scaledFont(name: "Montserrat-Medium", size:  16)
            }
            .onChange(of: fontToggle) { value in
                UserDefaults.standard.setScaledFontEnabled(value)
            }
            if !fontToggle {
                Section {
                    VStack {
                        Text("font.size".localized)
                            .padding()
                            .scaledFont(name: "Montserrat-Medium", size: 22)
                        Divider()
                        Image(systemName: "textformat.size")
                            .scaleEffect(1+(CGFloat(fontSize)/10))
                            .padding(.top)
                        LockerSlider(value: $fontSize, in: 10...22, step: 2)
                            .padding(EdgeInsets(top: 25, leading: 60, bottom: 20, trailing: 60))
                            .onChange(of: fontSize) { value in
                                UserDefaults.standard.setFontSize(value)
                            }
                    }
                }
                .transition(.scale)
            }
        }
        .animation(.linear(duration: 0.2), value: fontToggle)
        .onAppear() {
            self.fontToggle = UserDefaults.standard.scaledFontEnabled()
            self.fontSize = UserDefaults.standard.fontSize()
        }
        .onDisappear() {
            self.fontToggle = UserDefaults.standard.scaledFontEnabled()
            self.fontSize = UserDefaults.standard.fontSize()
        }
    }
}

struct FontSizeView_Previews: PreviewProvider {
    static var previews: some View {
        FontSizeView()
    }
}
