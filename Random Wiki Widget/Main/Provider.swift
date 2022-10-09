//
//  Provider.swift
//  Random Wiki WidgetExtension
//
//  Created by Sean Erickson on 10/4/22.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    let ud = UserDefaults(suiteName: "group.com.RandomWikiWidget")!
    
    func placeholder(in context: Context) -> SimpleEntry {
        let title = ud.string(forKey: "articleTitle") ?? "failed to fetch from ud"
        let description = ud.string(forKey: "articleDescription") ?? "failed to fetch from ud"
         return SimpleEntry(date: Date(), title: title, description: description)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let title = ud.string(forKey: "articleTitle") ?? "failed to fetch from ud"
        let description = ud.string(forKey: "articleDescription") ?? "failed to fetch from ud"
        let entry = SimpleEntry(date: Date(), title: title, description: description)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let title = ud.string(forKey: "articleTitle") ?? "failed to fetch from ud"
        let description = ud.string(forKey: "articleDescription") ?? "failed to fetch from ud"
        let entry = SimpleEntry(date: Date(), title: title, description: description)
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}
