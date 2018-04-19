//
//  PersistentStore.swift
//  TrackMe
//
//  Created by Tamilarasu on 15/04/18.
//  Copyright © 2018 iTamilan. All rights reserved.
//

import Foundation
import CoreData

class PersistentStore {
    
    static let shared = PersistentStore()
    
    class func addOperation(_ block: @escaping () -> Swift.Void) {
        shared.operationQueue.addOperation(block)
    }
    
    class func initialize() {
        PersistentStore.addOperation {
            _ = PersistentStore.shared.persistentContainer
        }
    }
    
    // MARK: - Core Data stack
    
    lazy var operationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.qualityOfService = .userInitiated
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "TrackMe")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContextInQueue () {
        operationQueue.addOperation {
           self.saveContext()
        }
    }
    
    func saveContext () {
        let context = self.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
