//
//  CoreDataCRUD.swift
//  CoreData-T
//
//  Created by Andrew on 9/2/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

import Foundation
import CoreData
import UIKit.UIColor

struct CoreDataCRUD {
    private static var coreDataStack = CoreDataStack(modelName: "CoreData_T")
    
    static func createCat(name: String, color: UIColor) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: NSStringFromClass(Cat.self), in: coreDataStack.context) else { return }
        let cat = Cat(entity: entityDescription, insertInto: coreDataStack.context)
        cat.setValue(name, forKey: "name")
        cat.setValue(color, forKey: "color")
        coreDataStack.saveContext()
    }
    
    static func readCat(name: String) -> Cat? {
        var cat: Cat? = nil
        let request: NSFetchRequest<Cat> = Cat.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try coreDataStack.context.fetch(request)
            if results.count > 0 {
                cat = results.first
            }
        } catch let error {
            print(error.localizedDescription)
        }
        return cat
    }
    
    static func updateCat(name: String, newName: String, newColor: UIColor) {
        let request: NSFetchRequest<Cat> = Cat.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try coreDataStack.context.fetch(request)
            if results.count > 0 {
                guard let cat = results.first else { return }
                cat.name = newName
                cat.color = newColor
                coreDataStack.saveContext()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    static func deleteCat(name: String) {
        let request: NSFetchRequest<Cat> = Cat.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try coreDataStack.context.fetch(request)
            if results.count > 0 {
                guard let cat = results.first else { return }
                coreDataStack.context.delete(cat)
                coreDataStack.saveContext()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
