//
//  Shapes+CoreDataProperties.swift
//  Storybook
//
//  Created by Adam Ibnu fiadi on 31/10/22.
//
//

import Foundation
import CoreData


extension Shapes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Shapes> {
        return NSFetchRequest<Shapes>(entityName: "Shapes")
    }

    @NSManaged public var background: String?
    @NSManaged public var challengeName: String?
    @NSManaged public var order: Int32
    @NSManaged public var level: String?

}

extension Shapes : Identifiable {

}
