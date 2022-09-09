//
//  UserDefaultsExtensions.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/4/22.
//

import Foundation
import SwiftUI

// MARK: - Favorites List
extension UserDefaults {
    
    func saveArticles(_ articles: [Article]) {
        var data: [Data] = []
        for article in articles {
            if let json = article.toJSON() { data.append(json) }
        }
        set(data, forKey: "favorites")
    }
    
    func loadArticles() -> [Article]? {
        var articles: [Article] = []
        guard let data = array(forKey: "favorites") as? [Data] else { return nil }
        let decoder = JSONDecoder()
        for datum in data {
            do {
                let decoded = try decoder.decode(Article.self, from: datum)
                articles.append(decoded)
            } catch {
                print(error)
                continue
            }
        }
        return articles
    }
    
    func clear() {
        removeObject(forKey: "favorites")
    }
}

// MARK: - Scaled Font
extension UserDefaults {
    
    func setScaledFontEnabled(_ enabled: Bool) {
        set(enabled, forKey: "scaledFontEnabled")
    }
    
    func scaledFontEnabled() -> Bool {
        return bool(forKey: "scaledFontEnabled")
    }
}

// MARK: - Custom Font Size
extension UserDefaults {
    
    func setFontSize(_ size: Float) {
        set(size, forKey: "customFontSize")
    }
    
    func fontSize() -> Float {
        return float(forKey: "customFontSize")
    }
}
