//
//  Article.swift
//  RandomWiki
//
//  Created by Sean Erickson on 8/29/22.
//

import Foundation

struct Article: Identifiable, Codable {
    var id: UUID
    var url: URL?
    var saved: Bool = false
    var category: String
    var title: String
    
    func toJSON() -> Data? {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            return data
        } catch { print(error) }
        return nil
    }
}


