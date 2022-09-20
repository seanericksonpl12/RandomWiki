//
//  ScaledFont.swift
//  RandomWiki
//
//  Code snippet created by Paul Hudson
//  Twitter: @twostraws
//  Starting Code from: https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-dynamic-type-with-a-custom-font
//

import SwiftUI

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    @AppStorage("customFontSize") var fontSize: Double = Double(UserDefaults.standard.fontSize())
    var name: String
    var size: Double
    
    func body(content: Content) -> some View {
        if UserDefaults.standard.scaledFontEnabled() {
            let scaledSize = UIFontMetrics.default.scaledValue(for: size)
            return content.font(.custom(name, size: scaledSize))
        } else {
            let ratio = size / 16.0
            return content.font(.custom(name, size: CGFloat(Float(fontSize) * Float(ratio))))
        }
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {
    func scaledFont(name: String, size: Double) -> some View {
        return self.modifier(ScaledFont(name: name, size: size))
    }
}
