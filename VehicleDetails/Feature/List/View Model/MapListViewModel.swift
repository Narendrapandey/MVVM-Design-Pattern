//
//  MapListViewModel.swift
//  VehicleDetails
//
//  Created by Narendra Pandey on 04/05/21.
//

import Foundation

class MapListViewModel {
    
    // MARK: - Properties -
    var error: String? {
        didSet {
            showAlertClosure?()
        }
    }
    
    var isLoading: Bool = false {
        didSet { updateLoadingStatus?() }
    }
    
    var listOfVehicle: [VehicleList]! {
        didSet { didFinishFetch?() }
    }
    
    private var service: WebService?
    
    // MARK: - Closures for callback
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    final private let persistance = CoreDataService.shared.persistentContainer
    
    // MARK: - Constructor
    init(service: WebService) {
        self.service = service
    }
    
    // MARK: - Network call
    func getVehicleList() {
        let vehicleList = getVehicleListFromDB()
        
        if vehicleList.isEmpty {
            setUpNetworkCall()
        } else {
            plog("From DB")
            DispatchQueue.main.async {
                self.listOfVehicle = vehicleList
            }
        }
    }
    
    final private func setUpNetworkCall() {
        isLoading = true
        
        WebService.shared.getVehicleList(.getVehicleList) { response in
            
            self.isLoading = false
            
            if let response = response {
                DispatchQueue.main.async {
                    self.listOfVehicle = response
                    self.setOfflineData(response)
                }
            }
            
        } errorBlock: { error in
            self.error = error
            self.isLoading = false
        }
    }
    
    final private func setOfflineData(_ details: [VehicleList]) {
        details.forEach { vehicleList in
            let viewModel = QueryVehicleList(with: DBManager(persistentContainer: persistance))
            viewModel.insertList(response:vehicleList)
        }
    }
    
    final  private func getVehicleListFromDB() -> [VehicleList] {
        let viewModel = QueryVehicleList(with: DBManager(persistentContainer: persistance))
        return viewModel.getList(where: nil)
    }
}
