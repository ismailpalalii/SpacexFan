//
//  Favorites+CoreDataProperties.swift
//  SpacexFan
//
//  Created by İsmail Palalı on 1.09.2022.
//
//

import Foundation
import CoreData

extension Favorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest<Favorites>(entityName: "Favorites")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var country: String?
    @NSManaged public var company: String?
}

extension Favorites : Identifiable {

}
