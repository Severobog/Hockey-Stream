//
//  NewNote+CoreDataProperties.swift
//  Sports-Factor
//
//  Created by Демид Стариков on 01.09.2022.
//
//

import Foundation
import CoreData


extension NewNote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewNote> {
        return NSFetchRequest<NewNote>(entityName: "NewNote")
    }

    @NSManaged public var mainLabel: String?
    @NSManaged public var text: String?

}

extension NewNote : Identifiable {

}
