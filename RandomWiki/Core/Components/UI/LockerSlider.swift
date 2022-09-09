//
//  LockerSlider.swift
//  RandomWiki
//
//  Main slider calculations from @Den on Stack Overflow
//  https://github.com/nilotic
//  https://stackoverflow.com/questions/58286350/how-to-create-custom-slider-by-using-swiftui
//

import SwiftUI

struct LockerSlider<V>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    
    // MARK: - Value
    // MARK: Private
    @Binding private var value: V
    private let bounds: ClosedRange<V>
    private let step: V.Stride
    
    private let length: CGFloat = 20
    private let lineWidth: CGFloat = 2
    
    @State private var ratio: CGFloat = 0
    @State private var startX: CGFloat? = nil
    
    var range: Int { Int(Float(bounds.upperBound - bounds.lowerBound)) }
    
    // MARK: - Initializer
    init(value: Binding<V>, in bounds: ClosedRange<V>, step: V.Stride = 1) {
        _value  = value
        self.bounds = bounds
        self.step   = step
    }
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                // Track
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: proxy.size.width, height: 3)
                HStack(spacing: (proxy.size.width - (CGFloat(range)*3)) / CGFloat(range-1)){
                    ForEach(Range(1...range)) { i in
                        Rectangle()
                            .frame(idealWidth:5, maxWidth: .infinity, minHeight: 10, idealHeight: 10, maxHeight: 10)
                            .foregroundColor(.gray)
                    }
                }
                
                // Thumb
                Circle()
                    .foregroundColor(.black)
                    .frame(width: length, height: length)
                    .offset(x: (proxy.size.width - length) * ratio)
                    .gesture(DragGesture(minimumDistance: 0)
                        .onChanged({ updateStatus(value: $0, proxy: proxy) })
                        .onEnded { _ in startX = nil })
            }
            .frame(height: length)
            .simultaneousGesture(DragGesture(minimumDistance: 0)
                .onChanged({ update(value: $0, proxy: proxy) }))
            .onAppear {
                ratio = min(1, max(0,CGFloat(value / bounds.upperBound)))
            }
        }
    }
    
    // MARK: - Function
    // MARK: Private
    private func updateStatus(value: DragGesture.Value, proxy: GeometryProxy) {
        guard startX == nil else { return }
        
        let delta = value.startLocation.x - (proxy.size.width - length) * ratio
        startX = (length < value.startLocation.x && 0 < delta) ? delta : value.startLocation.x
    }
    
    private func update(value: DragGesture.Value, proxy: GeometryProxy) {
        guard let x = startX else { return }
        startX = min(length, max(0, x))
        
        var point = value.location.x - x
        let delta = proxy.size.width - length
        
        // Check the boundary
        if point < 0 {
            startX = value.location.x
            point = 0
            
        } else if delta < point {
            startX = value.location.x - delta
            point = delta
        }
        
        // Ratio
        var ratio = point / delta
   
        // Step
        if step != 1 {
            let unit = CGFloat(step) / CGFloat(bounds.upperBound)
            
            let remainder = ratio.remainder(dividingBy: unit)
            if remainder != 0 {
                ratio = ratio - CGFloat(remainder)
            }
        }
        self.ratio = ratio
        self.value = V(bounds.upperBound) * V(ratio)
    }
}
