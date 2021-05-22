//
//  EN_VehicleList+CoreDataProperties.swift
//  VehicleDetails
//
//  Created by Narendra Pandey on 03/05/21.
//
//

import Foundation
import CoreData


@objc(EN_VehicleList)
public class EN_VehicleList: NSManagedObject {

}

extension EN_VehicleList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EN_VehicleList> {
        return NSFetchRequest<EN_VehicleList>(entityName: "EN_VehicleList")
    }

    @NSManaged public var id: String?
    @NSManaged public var modelIdentifier: String?
    @NSManaged public var modelName: String?
    @NSManaged public var group: String?
    @NSManaged public var licensePlate: String?
    @NSManaged public var innerCleanliness: String?
    @NSManaged public var carImageUrl: String?
    @NSManaged public var vehicleToVehicleDetail: EN_VehicleDetail?
    @NSManaged public var vehicleToVehicleLocation: EN_Location?

}
