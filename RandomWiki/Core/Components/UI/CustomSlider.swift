//
//  CustomSlider.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/20/22.
//

import SwiftUI
import UIKit

struct CustomSlider: UIViewRepresentable {
    
    var min: Float
    var max: Float
    var step: Float
    @Binding var value: Float
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        slider.thumbTintColor = UIColor(named: "Text")
        slider.minimumTrackTintColor = .gray
        slider.maximumTrackTintColor = .gray
        slider.minimumValue = self.min
        slider.maximumValue = self.max
        slider.value = value
        slider.isContinuous = true
        slider.addTarget(context.coordinator, action: #selector(Coordinator.update(_:)), for: .valueChanged)
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = self.value
    }
    
    func makeCoordinator() -> CustomSlider.Coordinator {
        Coordinator(value: $value, step: step)
    }
    
    final class Coordinator: NSObject {
        var value: Binding<Float>
        var step: Float
        init(value: Binding<Float>, step: Float) {
            self.value = value
            self.step = step
        }
        @objc func update(_ sender: UISlider) {
            let steppedVal = roundf(sender.value / step) * step
            self.value.wrappedValue = steppedVal
            sender.value = steppedVal
        }
    }
}

