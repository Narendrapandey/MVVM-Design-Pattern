//
//  Extensions.swift
//  VehicleDetails
//
//  Created by Narendra Pandey on 04/05/21.
//

import UIKit

extension UIImage {
    
    func resizeImage() -> UIImage {
        let size = CGSize(width: 30, height: 60)
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }
}

extension UIView{
    func roundCorners(corners: UIRectCorner, radius: CGFloat, rect: CGRect) {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UITableView {
    
    func registerDeque<T: UITableViewCell>(type: T.Type,
                                           indexPath: IndexPath,
                                           _ isNibClass: Bool = true) -> T {
        
        if isNibClass { registerCell(type: type) }
        if let cell = dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T {
            return cell
        } else {
            return registerDeque(type: type, indexPath: indexPath, isNibClass)
        }
    }
    
    final private func registerCell<T: UITableViewCell>(type: T.Type) {
        register(UINib(nibName: String(describing: T.self), bundle: nil), forCellReuseIdentifier: String(describing: T.self))
    }
}
