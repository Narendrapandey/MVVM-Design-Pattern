//
//  AppleMapsSheetViewController.swift
//  VehicleDetails
//
//  Created by Narendra Pandey on 03/05/21.
//

import UIKit

class AppleMapsSheetViewController: UIViewController {
    
    // MARK: - Outlets -
    @IBOutlet final private weak var tableView: UITableView!
    var sheetCoordinator: UBottomSheetCoordinator?
    final private var setListOfVehicle =  [VehicleList]()
    
    var listOfVehicle: [VehicleList]! {
        didSet {
            setListOfVehicle = listOfVehicle
            tableView.reloadData()
        }
    }
    
    // MARK: - View Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sheetCoordinator?.startTracking(item: self)
    }
}

// MARK: - Prepare View -
private extension AppleMapsSheetViewController {
    
    final private func prepareView() {
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
}


// MARK: - Draggable Type -
extension AppleMapsSheetViewController: Draggable{
    func draggableView() -> UIScrollView? {
        return tableView
    }
}

// MARK: - Table View Delegate/Datasource -
extension AppleMapsSheetViewController: UITableViewDelegate,
                                        UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
         1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         setListOfVehicle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         "Vehicle List"
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
         .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
         nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.registerDeque(type: MapItemCell.self, indexPath: indexPath)
        cell.configure(model: setListOfVehicle[indexPath.row])
        return cell
    }
}
