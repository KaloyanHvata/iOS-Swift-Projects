//
//  Item+CoreDataProperties.swift
//  GroceryList
//
//  Created by Kaloyan Petrov on 11/24/15.
//  Copyright © 2015 kaloyanpetrov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Item {

    @NSManaged var image: NSData?
    @NSManaged var name: String?
    @NSManaged var note: String?
    @NSManaged var quantity: String?

}
