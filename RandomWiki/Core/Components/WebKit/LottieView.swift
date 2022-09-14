//
//  LottieView.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/6/22.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    // MARK: - Properties
    var animationName: String
    @Environment(\.colorScheme) var colorMode
    
    // MARK: - UIKit Adaptors
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = AnimationView()
        let keyPath = AnimationKeypath(keypath: "**.Rectangle 1.Fill 1.Color")
        let color = ColorValueProvider(UIColor.white.lottieColorValue)
        animationView.animation = Animation.named(animationName)
        animationView.logHierarchyKeypaths()
        if self.colorMode == .dark {
            animationView.setValueProvider(color, keypath: keyPath)
        }
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = .loop
        animationView.sizeThatFits(CGSize(width: 50, height: 50))
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<LottieView>) {
    }
}
