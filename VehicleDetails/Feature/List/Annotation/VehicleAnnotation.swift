//
//  VehicleAnnotation.swift
//  VehicleDetails
//
//  Created by Narendra Pandey on 04/05/21.
//

import Foundation
import MapKit

class VehicleAnnotation: MKPointAnnotation {
    
    // MARK: - Variable -
    var carImage: String?
    var vehicleId: String?
    
    // MARK: - Init -
    init(_ latitude: CLLocationDegrees,_
            longitude: CLLocationDegrees,
         title: String,
         subtitle: String,
         carImage: String,
         vehicleId: String) {
        super.init()
        self.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        self.title = title
        self.subtitle = subtitle
        self.carImage = carImage
        self.vehicleId = vehicleId
    }
}
