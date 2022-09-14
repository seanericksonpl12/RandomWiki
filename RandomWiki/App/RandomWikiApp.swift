//
//  RandomWikiApp.swift
//  RandomWiki
//
//  Created by Sean Erickson on 8/26/22.
//

import SwiftUI

@main
struct RandomWikiApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
            
        }
    }
}
