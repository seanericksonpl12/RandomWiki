//
//  Entry.swift
//  Random Wiki WidgetExtension
//
//  Created by Sean Erickson on 10/4/22.
//

import WidgetKit
import SwiftUI

struct SimpleEntry: TimelineEntry {
    let date: Date
    let title: String
    let description: String
    let image: Image?
    let imageFrame: CGRect?
    var horizontal: Bool = true
}
