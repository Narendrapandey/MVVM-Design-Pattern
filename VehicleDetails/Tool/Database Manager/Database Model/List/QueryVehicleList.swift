//
//  QueryVehicleList.swift
//  VehicleDetails
//
//  Created by Narendra Pandey on 03/05/21.
//

import Foundation
import CoreData

class QueryVehicleList {
    
    // MARK: - Variable -
    private let repository: DBManager<VehicleList>
    
    // MARK: - Initiallize -
    init(with repo: DBManager<VehicleList>) {
        repository = repo
    }
}

// MARK: - Query setup -
extension QueryVehicleList {
    
    func insertList(response: VehicleList) {
        try? repository.insert(item: response)
    }
    
    func getList(where predicate: NSPredicate?) -> [VehicleList] {
        let items: [VehicleList] = try! repository.getAll(where: predicate)
        return items
    }
}
