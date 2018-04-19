//
//  CoreDataManager.swift
//  TrackMe
//
//  Created by Tamilarasu on 15/04/18.
//  Copyright © 2018 iTamilan. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation

class CoreDataManager {
    
    class func add(_ locations: [CLLocation]) {
        PersistentStore.addOperation {
            let managedObjectContext = PersistentStore.shared.persistentContainer.viewContext
            for location in locations {
                if let locationObject: Location = NSEntityDescription.insertNewObject(forEntityName: "Location", into: managedObjectContext) as? Location {
                    locationObject.location = location
                }
            }
            PersistentStore.shared.saveContext()
        }
    }
}
