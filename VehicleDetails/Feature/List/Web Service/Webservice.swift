//
//  Webservice.swift
//  VehicleDetails
//
//  Created by Narendra Pandey on 03/05/21.
//

import Foundation

class WebService {
    
    // MARK: - Singleton
    static let shared = WebService()
    
    func getVehicleList(_ router: Router,
                        completion: @escaping ([VehicleList]?) -> (),
                        errorBlock: @escaping (String) -> ()) {
        
        URLSession.shared.dataTask(with: router.path) { data, response, error in
            
            if let error = error {
                errorBlock(error.localizedDescription)
                
            } else if let data = data {
                let decoded = try? JSONDecoder().decode([VehicleList].self, from: data)
                if decoded != nil {
                    completion(decoded)
                } else {
                    errorBlock("Invalid json")
                }
            }
        }.resume()
    }
}
