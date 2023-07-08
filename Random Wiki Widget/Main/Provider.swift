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
         return SimpleEntry(date: Date(), title: title, description: description, image: nil, imageFrame: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let title = ud.string(forKey: "articleTitle") ?? "failed to fetch from ud"
        let description = ud.string(forKey: "articleDescription") ?? "failed to fetch from ud"
        let entry = SimpleEntry(date: Date(), title: title, description: description, image: nil, imageFrame: nil)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let title = ud.string(forKey: "articleTitle") ?? "Couldn't seem to find a title"
        let description = ud.string(forKey: "articleDescription") ?? "...."
        let imgString = ud.string(forKey: "storedImage") ?? ""
        var entry = SimpleEntry(date: Date(), title: title, description: description, image: nil, imageFrame: nil)
        if let url = URL(string: imgString) {
            do {
                let data = try Data(contentsOf: url)
                if let uiImage = UIImage(data: data) {
                    entry = SimpleEntry(date: Date(), title: title, description: description, image: Image(uiImage: uiImage), imageFrame: CGRect(origin: .zero, size: uiImage.size))
                    if uiImage.size.width > uiImage.size.height { entry.horizontal = true }
                    else { entry.horizontal = false }
                }
            } catch { print(error) }
        }
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}
