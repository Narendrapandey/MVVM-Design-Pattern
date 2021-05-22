//
//  VehicleListDB.swift
//  VehicleDetails
//
//  Created by Narendra Pandey on 03/05/21.
//

import Foundation
import CoreData

// MARK: - Convert to storable entity -
extension VehicleList: Entity {
    
    public func toStorable(in context: NSManagedObjectContext, withSuperClass superClass: NSManagedObject?) -> EN_VehicleList? {
        
        let predicate = NSPredicate(format: "self.id = %@", id)
        let coreDataList = EN_VehicleList.getOrCreateSingle(with: predicate, from: context)
        
        coreDataList.id = id
        coreDataList.modelIdentifier = modelIdentifier
        coreDataList.modelName = modelName
        coreDataList.group = group
        coreDataList.licensePlate = licensePlate
        coreDataList.innerCleanliness = innerCleanliness
        coreDataList.carImageUrl = carImageUrl
        
        let _ = vehicleDetails?.toStorable(in: context, withSuperClass: coreDataList)
        let _ = location?.toStorable(in: context, withSuperClass: coreDataList)
        
        return coreDataList
    }
}

// MARK: - Get Modal -
extension EN_VehicleList: Storable {
    
    var primaryKey: String {
        get {
            return id ?? ""
        }
    }
    
    var model: VehicleList {
        get {
            
            return VehicleList(id: id ?? "",
                               modelIdentifier: modelIdentifier ?? "",
                               modelName: modelName ?? "",
                               group: group ?? "",
                               licensePlate: licensePlate ?? "",
                               innerCleanliness: innerCleanliness ?? "",
                               carImageUrl: carImageUrl ?? "",
                               vehicleDetails: vehicleToVehicleDetail?.model,
                               location: vehicleToVehicleLocation?.model)
        }
    }
}
