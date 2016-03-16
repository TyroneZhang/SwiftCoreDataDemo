//
//  Member.swift
//  SwiftCoreData
//
//  Created by Zhangyao on 15/3/2016.
//  Copyright © 2016 TZPT. All rights reserved.
//

import Foundation
import CoreData

@objc(Member)
class Member: NSManagedObject {

    class func createEntity(name: String?, birthday: String?, sex: String?, family: Family?) -> Member {
        let model = NSEntityDescription.insertNewObjectForEntityForName(NSStringFromClass(self), inManagedObjectContext: CoreDataHelper.shared.managedObjectContext) as! Member
        model.name = name != nil ? name: nil
        model.birthday = birthday != nil ? birthday : nil
        model.sex = sex != nil ? sex : nil
        model.family = family != nil ? family : nil
        CoreDataHelper.shared.saveContext()
        
        return model
    }

    func updateInformation() {
        CoreDataHelper.shared.saveContext()
    }
    
//    func deleteMember() {
//         CoreDataHelper.shared.managedObjectContext.deleteObject(self)
//    }
}
