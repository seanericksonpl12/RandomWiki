//
//  ArticleDetails.swift
//  RandomWiki
//
//  Used to pass web data scraped after
//  article is already created
//
//  Created by Sean Erickson on 9/11/22.
//

import Foundation

struct ArticleDetails {
    var url: URL?
    var title: String
    var description: String?
}
