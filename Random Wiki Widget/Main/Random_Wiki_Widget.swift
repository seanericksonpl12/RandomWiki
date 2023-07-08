//
//  Random_Wiki_Widget.swift
//  Random Wiki Widget
//
//  Created by Sean Erickson on 10/4/22.
//

import WidgetKit
import SwiftUI

@main
struct Random_Wiki_Widget: Widget {
    let kind: String = "Random_Wiki_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            EntryView(entry: entry)
        }
        .supportedFamilies([.systemLarge, .systemMedium, .accessoryRectangular])
        .configurationDisplayName("Random Wiki")
        .description("View the newest random article")
    }
}

struct Random_Wiki_Widget_Previews: PreviewProvider {
    static var previews: some View {
        EntryView(entry: SimpleEntry(date: Date(), title: "fdsfgsd", description: "fjdksf", image: nil, imageFrame: nil))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
