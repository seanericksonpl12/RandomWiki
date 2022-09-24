//
//  ScaledFont.swift
//  RandomWiki
//
//
//

import SwiftUI

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    @AppStorage("customFontSize") var fontSize: Double = UserDefaults.standard.fontSize()
    @AppStorage("scaledFontEnabled") var scaledFontEnabled: Bool = UserDefaults.standard.scaledFontEnabled()
    var name: String
    var size: Double
    
    func body(content: Content) -> some View {
        if scaledFontEnabled {
            let scaledSize = UIFontMetrics.default.scaledValue(for: size)
            return content.font(.custom(name, size: scaledSize))
        } else {
            let ratio = size / 16.0
            return content.font(.custom(name, size: CGFloat(Float(fontSize) * Float(ratio))))
        }
    }
}

@available(iOS 13, *)
extension View {
    func scaledFont(name: String, size: Double) -> some View {
        return self.modifier(ScaledFont(name: name, size: size))
    }
}
