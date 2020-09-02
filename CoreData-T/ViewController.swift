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
        
    }

    @IBAction func save(_ sender: UIButton) {
        CoreDataCRUD.createCat(name: "Leo", color: .cyan)
    }
    
    @IBAction func retrieveData(_ sender: UIButton) {
        print(CoreDataCRUD.readCat(name: "Leo"))
    }
    
    @IBAction func updateData(_ sender: UIButton) {
//        fetchRequest.predicate = NSPredicate(format: "name CONTAINS[c] 'j'")
//        fetchRequest.predicate = NSPredicate(format: "name BEGINSWITH[c] 'jo'")
//        fetchRequest.predicate = NSPredicate(format: "name ENDSWITH[c] 'hn'")
//        fetchRequest.predicate = NSPredicate(format: "name LIKE[c] %@", "Jo*")
        CoreDataCRUD.updateCat(name: "Leo", newName: "Rob", newColor: .green)
    }
    
    @IBAction func deleteData(_ sender: UIButton) {
        CoreDataCRUD.deleteCat(name: "Leo")
    }


}

