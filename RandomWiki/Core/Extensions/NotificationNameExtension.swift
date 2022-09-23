//
//  NotificationNameExtension.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/22/22.
//

import Foundation

extension Notification.Name {
    static let updateWebView = Notification.Name("updateWebView")
}

extension Notification {
    static let updateWebView = Notification(name: .updateWebView)
}
