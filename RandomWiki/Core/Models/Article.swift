//
//  Article.swift
//  RandomWiki
//
//  Created by Sean Erickson on 8/29/22.
//

import Foundation

struct Article: Identifiable, Codable, Hashable {
    var id: UUID
    var url: URL?
    var saved: Bool = false
    var category: String?
    var title: String
    var description: String?
    var expanded: Bool = false
}


