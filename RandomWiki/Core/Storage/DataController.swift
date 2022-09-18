//
//  DataController.swift
//  RandomWiki
//
//  Created by Sean Erickson on 9/10/22.
//

import Foundation
import CoreData

enum StorageType {
    case persistant, inMemory
}

class DataController: ObservableObject {
    let container: NSPersistentContainer
    
    init(_ storageType: StorageType = .persistant) {
        self.container = NSPersistentContainer(name: "DataStorage")
        
        if storageType == .inMemory {
            if #available(iOS 16.0, *) {
                let description = NSPersistentStoreDescription(url: URL(filePath: "/dev/null"))
                self.container.persistentStoreDescriptions = [description]
            } else { print("In Memory Data Storage Failed: iOS 16 not available") }
        }
        
        self.container.loadPersistentStores { description, error in
            if let error = error { print(error.localizedDescription) }
        }
    }
}
