//
//  EN_VehicleDetail+CoreDataProperties.swift
//  VehicleDetails
//
//  Created by Narendra Pandey on 03/05/21.
//
//

import Foundation
import CoreData


@objc(EN_VehicleDetail)
public class EN_VehicleDetail: NSManagedObject {

}

extension EN_VehicleDetail {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<EN_VehicleDetail> {
        return NSFetchRequest<EN_VehicleDetail>(entityName: "EN_VehicleDetail")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var make: String?
    @NSManaged public var color: String?
    @NSManaged public var series: String?
    @NSManaged public var fuel_type: String?
    @NSManaged public var transmission: String?
    @NSManaged public var fuel_level: Double
    @NSManaged public var vehicleId: String
    @NSManaged public var vehicleDetails: EN_VehicleList?
    
}
