//
//  Family.swift
//  SwiftCoreData
//
//  Created by Zhangyao on 15/3/2016.
//  Copyright © 2016 TZPT. All rights reserved.
//

import Foundation
import CoreData

@objc(Family)
class Family: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    class func saveFamilyModel(name: String?, address: String?, members: NSSet?) -> Family? {
        let family = NSEntityDescription.insertNewObjectForEntityForName(NSStringFromClass(self), inManagedObjectContext: CoreDataHelper.shared.managedObjectContext) as! Family
        family.name = name != nil ? name! : nil
        family.address = address != nil ? address : nil
        family.members = members != nil ? members : nil
        CoreDataHelper.shared.saveContext()
        return family
    }
    
    class func fetchFamilyModels() -> Array<Family>? {
        let fetchRequest:NSFetchRequest = NSFetchRequest()
        /* limit
        fetchRequest.fetchLimit = 10
        fetchRequest.fetchOffset = 0
*/
        let entity:NSEntityDescription? = NSEntityDescription.entityForName(NSStringFromClass(self), inManagedObjectContext: CoreDataHelper.shared.managedObjectContext)
        fetchRequest.entity = entity
        /*  add some condition to fetch data
        let predicate = NSPredicate(format: "name = '张家'")
        fetchRequest.predicate = predicate
*/
        var families:[Family] = []
        do {
            let fetchedObjects:[AnyObject]? = try CoreDataHelper.shared.managedObjectContext.executeFetchRequest(fetchRequest)
            for family:Family in fetchedObjects as! [Family] {
                families.append(family)
            }
            return families
        } catch {
            fatalError("fetch error \(error)")
        }
    }
    
    class func deleteFamily(family: Family) {
        CoreDataHelper.shared.managedObjectContext.deleteObject(family)
        CoreDataHelper.shared.saveContext()
    }
    
    func updateData() {
        CoreDataHelper.shared.saveContext()
    }
    
    func deleteMember(member: Member) {
        CoreDataHelper.shared.managedObjectContext.deleteObject(member)
        CoreDataHelper.shared.saveContext()
    }
    
}
