//
//  CoreDataStack.swift
//  CoreData-T
//
//  Created by Andrew on 8/31/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    lazy var context: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                print("Unresolved error \(error), \(error.localizedDescription)")
            }
        }
        return container
    }()
}

// MARK: Internal
extension CoreDataStack {
    func saveContext() {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch let error {
            fatalError("Unresolved error \(error), \(error.localizedDescription)")
        }
    }
}
