//
//  NotificationViewTests.swift
//  RandomWikiTests
//
//  Created by Sean Erickson on 9/19/22.
//

import XCTest
import ViewInspector
import SwiftUI
@testable import RandomWiki

extension NotificationsView: Inspectable {}

class NotificationViewTests: XCTestCase {
    
    var view: NotificationsView!
    
    override func setUp() {
        super.setUp()
        view = NotificationsView()
        continueAfterFailure = false
    }
    
    func testSwitch() {
        let exp = view.inspection.inspect { view in
            try view.actualView().notificationsAllowed = false
            XCTAssertFalse(try view.actualView().notificationsAllowed)
            try view.list().toggle(0).callOnChange(newValue: true)
            try view.list().callOnAppear()
            XCTAssertTrue(try view.actualView().notificationsAllowed)
        }
        ViewHosting.host(view: view)
        wait(for: [exp], timeout: 5)
    }
    
    func testWeekly() {
        let exp = view.inspection.inspect { view in
            try view.actualView().notificationsAllowed = true
            UserDefaults.standard.setNotifications(to: .weekly)
            try view.list().callOnAppear()
            UserDefaults.standard.setWeeklyNotification(to: 1)
            try view.list().section(1).picker(1).callOnChange(newValue: 2)
            try view.list().callOnAppear()
            XCTAssertEqual(2, UserDefaults.standard.getWeeklyNotification())
        }
        ViewHosting.host(view: view)
        wait(for: [exp], timeout: 5)
    }
    
    func testDaily() {
        let exp = view.inspection.inspect { view in
            UserDefaults.standard.setNotifications(to: .weekly)
            try view.list().callOnAppear()
            try view.actualView().notificationsAllowed = true
            try view.list().section(1).picker(0).callOnChange(newValue: RandomWiki.NotificationOptions.daily)
            try view.list().callOnAppear()
            XCTAssertEqual(UserDefaults.standard.getNotificationOptions(), .daily)
        }
        ViewHosting.host(view: view)
        wait(for: [exp], timeout: 5)
    }
}
