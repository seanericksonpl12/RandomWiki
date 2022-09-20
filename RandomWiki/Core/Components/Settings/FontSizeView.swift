//
//  FontSizeView.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/7/22.
//

import SwiftUI

struct FontSizeView: View {
    @State var fontToggle: Bool = UserDefaults.standard.scaledFontEnabled()
    @State var fontSize: Float = UserDefaults.standard.fontSize()
    
    // MARK: - Testing
    internal let inspection = Inspection<Self>()
    
    // MARK: - Body
    var body: some View {
        List {
            Toggle(isOn: $fontToggle) {
                Text("font.adjust".localized)
                    .scaledFont(name: "Montserrat-Medium", size:  16)
            }
            .onChange(of: fontToggle) {
                UserDefaults.standard.setScaledFontEnabled($0)
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
                        LockerSlider(value: $fontSize, in: 0...12, step: 2)
                            .padding(EdgeInsets(top: 25, leading: 60, bottom: 20, trailing: 60))
                            .onChange(of: fontSize) {
                                UserDefaults.standard.setFontSize($0 + 10)
                            }
                    }
                }
                .transition(.scale)
            }
        }
        .animation(.linear(duration: 0.2), value: fontToggle)
        .onAppear() {
            self.fontToggle = UserDefaults.standard.scaledFontEnabled()
            self.fontSize = UserDefaults.standard.fontSize() - 10
        }
        .onDisappear() {
            self.fontToggle = UserDefaults.standard.scaledFontEnabled()
            self.fontSize = UserDefaults.standard.fontSize() - 10
        }
        .navigationTitle("Font")
        .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
}

struct FontSizeView_Previews: PreviewProvider {
    static var previews: some View {
        FontSizeView()
    }
}
