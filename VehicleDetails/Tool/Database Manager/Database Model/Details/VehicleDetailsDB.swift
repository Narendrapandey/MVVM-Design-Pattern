//
//  VehicleDetailsDB.swift
//  VehicleDetails
//
//  Created by Narendra Pandey on 03/05/21.
//

import Foundation
import CoreData

// MARK: - Convert to storable entity -
extension VehicleDetails: Entity {
    
    public func toStorable(in context: NSManagedObjectContext, withSuperClass superClass: NSManagedObject?) -> EN_VehicleDetail? {
        
        guard let superClass = superClass,
              let vehicleList = superClass as? EN_VehicleList else { return nil}
        
        let predicate = NSPredicate(format: "self.vehicleId = %@", vehicleList.id ?? "")
        
        let coreDataDetail = EN_VehicleDetail.getOrCreateSingle(with: predicate, from: context)
        
        coreDataDetail.vehicleId = vehicleList.id ?? ""
        coreDataDetail.name = name
        coreDataDetail.make = make
        coreDataDetail.color = color
        coreDataDetail.series = series
        coreDataDetail.fuel_type = fuel_type
        coreDataDetail.fuel_level = fuel_level
        coreDataDetail.transmission = transmission
        coreDataDetail.vehicleDetails = vehicleList
        
        return coreDataDetail
    }
}

// MARK: - Get Modal -
extension EN_VehicleDetail: Storable {
    
    var primaryKey: String {
        get {
            return vehicleId
        }
    }
    
    var model: VehicleDetails {
        get {
            
            return VehicleDetails(name: name ?? "",
                                  make: make ?? "",
                                  color: color ?? "",
                                  series: series ?? "",
                                  fuel_type: fuel_type ?? "",
                                  fuel_level: fuel_level,
                                  transmission: transmission ?? "")
        }
    }
}
