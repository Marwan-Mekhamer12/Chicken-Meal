//
//  Entity+CoreDataProperties.swift
//  Chicken Meal
//
//  Created by Marwan Mekhamer on 03/08/2025.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var name: String?
    @NSManaged public var area: String?
    @NSManaged public var category: String?

}

extension Entity : Identifiable {

}
