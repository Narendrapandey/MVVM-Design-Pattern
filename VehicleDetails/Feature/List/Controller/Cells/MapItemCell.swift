//
//  MapItemCell.swift
//  UBottomSheet_Example
//
//  Created by ugur on 1.05.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class MapItemCell: UITableViewCell {
    
    // MARK: - Outlets -
    @IBOutlet final private weak var leftImageView: UIImageView!
    @IBOutlet final private weak var nameLabel: UILabel!
    @IBOutlet final private weak var descriptionLabel: UILabel!
    @IBOutlet final private weak var progressView: UIProgressView!
    
    // MARK: - Variable -
    final private let placeHolderImage = "placeHolder"
    
    // MARK: - View Life Cycle -
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configure(model: VehicleList) {
        
        leftImageView.image = ImageLoader.shared.cacheImage(from: URL(string: model.carImageUrl))
        
        if let vehicleDetail = model.vehicleDetails {
            nameLabel.text = vehicleDetail.name + ", " + vehicleDetail.make + ", " + vehicleDetail.series
            descriptionLabel.text = model.modelName + ", " + model.licensePlate + ", " + vehicleDetail.transmission
            progressView.progress = Float(vehicleDetail.fuel_level)
        }
    }
}
