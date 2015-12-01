//
//  Medicine+CoreDataProperties.swift
//  MedicalHelper
//
//  Created by Kaloyan Petrov on 11/26/15.
//  Copyright © 2015 kaloyanpetrov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Medicine {

    @NSManaged var name: String?
    @NSManaged var dosage: String?
    @NSManaged var time: String?

}
