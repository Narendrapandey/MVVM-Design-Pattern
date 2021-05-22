//
//  Router.swift
//  VehicleDetails
//
//  Created by Narendra Pandey on 04/05/21.
//

import Foundation

protocol Routable {
    var path: URL { get }
}

enum Router: Routable {
    case getVehicleList
}

extension Router {
    
    var path: URL {
        switch self{
        
        case .getVehicleList:
            return URL(string: Environment.APIBasePath() + "/v3/1322e4fb-d566-480a-aead-b3165427c308")!
        }
    }
}
