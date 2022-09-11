//
//  DataController.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/10/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "DataStorage")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error { print(error.localizedDescription) }
        }
    }
}
