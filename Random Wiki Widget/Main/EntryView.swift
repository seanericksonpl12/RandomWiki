//
//  EntryView.swift
//  Random Wiki WidgetExtension
//
//  Created by Sean Erickson on 10/4/22.
//

import WidgetKit
import SwiftUI

struct EntryView: View {
    @Environment(\.widgetFamily) var widgetSize
    var entry: Provider.Entry

    var body: some View {
        switch widgetSize {
        case .systemMedium:
            MediumWidgetView(entry: entry)
        case .systemLarge:
            LargeWidgetView(entry: entry)
        default:
            Text("Not Provided")
        }
    }
}
