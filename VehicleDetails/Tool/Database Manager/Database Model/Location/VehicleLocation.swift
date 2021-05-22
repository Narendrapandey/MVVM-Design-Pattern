//
//  VehicleLocation.swift
//  VehicleDetails
//
//  Created by Narendra Pandey on 03/05/21.
//

import Foundation
import CoreData

// MARK: - Convert to storable entity -
extension Location: Entity {
    
    public func toStorable(in context: NSManagedObjectContext, withSuperClass superClass: NSManagedObject?) -> EN_Location? {
        
        guard let superClass = superClass,
              let vehicleList = superClass as? EN_VehicleList else { return nil}
        
        let predicate = NSPredicate(format: "self.vehicleId = %@", vehicleList.id ?? "")
        
        let coreDataLocation = EN_Location.getOrCreateSingle(with: predicate, from: context)
        coreDataLocation.vehicleId = vehicleList.id ?? ""
        coreDataLocation.latitude = latitude
        coreDataLocation.longitude = longitude
        coreDataLocation.locationOfVehicle = vehicleList
        
        return coreDataLocation
    }
}

// MARK: - Get Modal -
extension EN_Location: Storable {
    
    var primaryKey: String {
        get {
            return vehicleId 
        }
    }
    
    var model: Location {
        get {
            
            return Location(latitude: latitude,
                            longitude: longitude)
        }
    }
}
