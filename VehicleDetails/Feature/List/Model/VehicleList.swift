//
//  VehicleList.swift
//  VehicleDetails
//
//  Created by Narendra Pandey on 03/05/21.
//

import Foundation

struct VehicleList: Decodable {
    let id: String
    let modelIdentifier: String
    let modelName: String
    let group: String
    let licensePlate: String
    let innerCleanliness: String
    let carImageUrl: String
    let vehicleDetails: VehicleDetails?
    let location: Location?
}

struct VehicleDetails: Decodable {
    let name: String
    let make: String
    let color: String
    let series: String
    let fuel_type: String
    let fuel_level: Double
    let transmission: String
}

struct Location: Decodable {
    let latitude: Double
    let longitude: Double
}
