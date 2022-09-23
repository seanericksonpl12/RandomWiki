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

@MainActor class NotificationViewTests: XCTestCase {
    
    var viewModel: NotificationsView.NotificationsViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = NotificationsView.NotificationsViewModel()
        continueAfterFailure = false
    }
    
    func testSwitch() {
        viewModel.notificationsAllowed = false
        viewModel.update()
        XCTAssertFalse(UserDefaults.standard.notificationsEnabled())
        viewModel.notificationsAllowed = true
        viewModel.update()
        XCTAssertTrue(UserDefaults.standard.notificationsEnabled())
    }
    
    func testWeekly() {
        viewModel.selectedDay = 3
        viewModel.update()
        XCTAssertEqual(UserDefaults.standard.getWeeklyNotification(), 3)
        viewModel.selectedDay = 1
        viewModel.update()
        XCTAssertEqual(UserDefaults.standard.getWeeklyNotification(), 1)
    }
    
    func testDaily() {
        viewModel.selectedOption = .daily
        viewModel.update()
        XCTAssertEqual(UserDefaults.standard.getNotificationOptions(), .daily)
        viewModel.selectedOption = .weekly
        viewModel.update()
        XCTAssertEqual(UserDefaults.standard.getNotificationOptions(), .weekly)
    }
}
