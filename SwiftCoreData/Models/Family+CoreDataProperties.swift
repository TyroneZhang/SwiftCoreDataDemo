//
//  Family+CoreDataProperties.swift
//  SwiftCoreData
//
//  Created by Zhangyao on 15/3/2016.
//  Copyright © 2016 TZPT. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Family {

    @NSManaged var address: String?
    @NSManaged var name: String?
    @NSManaged var members: NSSet?

}
