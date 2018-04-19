//
//  Locations+CoreDataProperties.swift
//  TrackMe
//
//  Created by Tamilarasu on 15/04/18.
//  Copyright © 2018 iTamilan. All rights reserved.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Locations")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var location: NSObject?

}
