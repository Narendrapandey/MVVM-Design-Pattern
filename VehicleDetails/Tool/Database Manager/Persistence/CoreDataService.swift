//
//  CoreDataService.swift
//  VehicleDetails
//
//  Created by Narendra Pandey on 03/05/21.
//

import Foundation
import CoreData

class CoreDataService {
    
    static let shared = CoreDataService()
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "VehicleDetails")
        container.loadPersistentStores(completionHandler: { [weak self](storeDescription, error) in
            if let error = error {
                NSLog("CoreData error \(error), \(String(describing: error._userInfo))")
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        let context: NSManagedObjectContext = self.persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
}
