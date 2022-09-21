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
            XCTAssertFalse(UserDefaults.standard.notificationsEnabled())
            try view.actualView().notificationsAllowed = true
            XCTAssertTrue(UserDefaults.standard.notificationsEnabled())
        }
        ViewHosting.host(view: view)
        wait(for: [exp], timeout: 5)
    }
    
    func testWeekly() {
        let exp = view.inspection.inspect { view in
            try view.actualView().notificationsAllowed = true
            try view.actualView().selectedDay = 1
            XCTAssertEqual(UserDefaults.standard.getWeeklyNotification(), 1)
            try view.actualView().selectedDay = 2
            XCTAssertEqual(UserDefaults.standard.getWeeklyNotification(), 2)
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
