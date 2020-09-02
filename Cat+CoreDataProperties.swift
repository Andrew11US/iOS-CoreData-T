//
//  Cat+CoreDataProperties.swift
//  CoreData-T
//
//  Created by Andrew on 9/2/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit.UIColor

extension Cat {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cat> {
        return NSFetchRequest<Cat>(entityName: "Cat")
    }

    @NSManaged public var color: UIColor?
    @NSManaged public var name: String?
}
