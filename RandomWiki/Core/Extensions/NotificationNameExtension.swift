//
//  NotificationNameExtension.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/22/22.
//

import Foundation

extension Notification.Name {
    static let updateWebView = Notification.Name("updateWebView")
    static let readText = Notification.Name("readText")
    static let checkCurrentArticle = Notification.Name("checkCurrentArticle")
}

extension Notification {
    static let updateWebView = Notification(name: .updateWebView)
    static let readText = Notification(name: .readText)
    static let checkCurrentArticle = Notification(name: .checkCurrentArticle)
}
