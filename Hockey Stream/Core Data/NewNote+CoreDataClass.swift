//
//  NewNote+CoreDataClass.swift
//  Sports-Factor
//
//  Created by Демид Стариков on 01.09.2022.
//
//

import Foundation
import CoreData

@objc(NewNote)
public class NewNote: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "NewNote"), insertInto: CoreDataManager.instance.context)
    }
}
