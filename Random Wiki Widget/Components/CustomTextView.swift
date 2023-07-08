//
//  CustomTextView.swift
//  Random Wiki WidgetExtension
//
//  Created by Sean Erickson on 10/17/22.
//

import Foundation
import UIKit
import SwiftUI

struct CustomTextView: UIViewRepresentable {
    
     var text: String
     var layoutFrame: CGRect
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.text = text
        let frame = view.convert(layoutFrame, to: nil).offsetBy(dx: .leastNonzeroMagnitude, dy: .zero)
        let path = UIBezierPath(rect: frame)
        view.textContainer.exclusionPaths = [path]
        print("text: \(text)")
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        print("text: \(text)")
        uiView.text = text
        let path = UIBezierPath(rect: layoutFrame)
        uiView.textContainer.exclusionPaths = [path]
    }
}
