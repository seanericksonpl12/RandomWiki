//
//  RandomWikiApp.swift
//  RandomWiki
//
//  Created by Sean Erickson on 8/26/22.
//

import SwiftUI
import StoreKit

@main
struct RandomWikiApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var dataController = DataController()
    @StateObject var store: StoreManager = StoreManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .onAppear {
                    SKPaymentQueue.default().add(store)
                    store.getProduct(productID: "42069")
                }
        }
    }
}
