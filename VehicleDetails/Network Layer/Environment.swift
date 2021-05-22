//
//  Environment.swift
//  VehicleDetails
//
//  Created by Narendra Pandey on 04/05/21.
//

import Foundation

enum Server {
    case production
    case staging
}

class Environment {
    
    // MARK: - Variables -
    static let server: Server    =   .staging
    
    static let staging = "https://run.mocky.io"
    static let production = "https://run.mocky.io"
    
    // MARK: - main Base Path -
    class func mainBasePath() -> String {
        switch server {
        case .staging:
            return staging
        case .production:
            return production
        }
    }
    
    // MARK: - Get API Base Path -
    class func APIBasePath() -> String {
         Environment.mainBasePath()
    }
}
