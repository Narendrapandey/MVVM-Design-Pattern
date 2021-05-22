//
//  EN_Location+CoreDataProperties.swift
//  VehicleDetails
//
//  Created by Narendra Pandey on 03/05/21.
//
//

import Foundation
import CoreData


@objc(EN_Location)
public class EN_Location: NSManagedObject {

}

extension EN_Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EN_Location> {
        return NSFetchRequest<EN_Location>(entityName: "EN_Location")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var vehicleId: String
    @NSManaged public var locationOfVehicle: EN_VehicleList?

}
