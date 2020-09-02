//
//  ViewController.swift
//  CoreData-T
//
//  Created by Andrew on 8/31/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    lazy var coreDataStack = CoreDataStack(modelName: "CoreData_T")
    var cat: Cat? {
        didSet {
            guard let cat = cat else { return }
            print(cat.name)
            view.backgroundColor = cat.color
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveData(UIButton())
    }

    @IBAction func save(_ sender: UIButton) {
//        guard let cat = cat else { return }
//        cat.name = "Leo"
//        cat.color = .yellow
        
        let cat2 = Cat(entity: NSEntityDescription.entity(forEntityName: "Cat", in: coreDataStack.context)!, insertInto: coreDataStack.context)
        cat2.name = "Leo"
        cat2.color = .red
        
        do {
            try coreDataStack.context.save()
            print("Saved!")
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func retrieveData(_ sender: UIButton) {
        let fetchRequest: NSFetchRequest<Cat> = Cat.fetchRequest()
        do {
            let results = try coreDataStack.context.fetch(fetchRequest)
            if results.count > 0 {
                cat = results.first
            } else {
                cat = Cat(context: coreDataStack.context)
                coreDataStack.saveContext()
            }
            print(cat)
            print(results.count)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func updateData(_ sender: UIButton) {
        let fetchRequest: NSFetchRequest<Cat> = Cat.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "name CONTAINS[c] 'j'")
//        fetchRequest.predicate = NSPredicate(format: "name BEGINSWITH[c] 'jo'")
//        fetchRequest.predicate = NSPredicate(format: "name ENDSWITH[c] 'hn'")
        fetchRequest.predicate = NSPredicate(format: "name LIKE[c] %@", "Jo*")
        do {
            let results = try coreDataStack.context.fetch(fetchRequest)
//            if results.count > 0 {
//                for result in results {
//                    if result.name == "Leo" {
//                        result.name = "CatX"
//                        result.color = .gray
//                        coreDataStack.saveContext()
//                    }
//                }
//            } else {
//                print("not found")
//            }
            print(results.count)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func deleteData(_ sender: UIButton) {
        let fetchRequest: NSFetchRequest<Cat> = Cat.fetchRequest()
        do {
            let results = try coreDataStack.context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results {
                    if result.name == "CatX" {
                        coreDataStack.context.delete(result)
                        coreDataStack.saveContext()
                    }
                }
            } else {
                print("not found")
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }


}

