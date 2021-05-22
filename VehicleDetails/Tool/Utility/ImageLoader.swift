//
//  ImageLoader.swift
//  VehicleDetails
//
//  Created by Narendra Pandey on 04/05/21.
//

import UIKit

class ImageLoader {
    
    private let cache = NSCache<NSString, UIImage>()
    final private let placeHolderImage = "placeHolder"
    
    // MARK: - Singleton
    static let shared = ImageLoader()
    
    func cacheImage(from url: URL?) -> UIImage {
        guard  let url = url else {
            return UIImage(named: self.placeHolderImage)!.resizeImage()
        }
        let cachedImage = cache.object(forKey: url.absoluteString as NSString)
        if cachedImage == nil {
            downloadImage(url.absoluteString as NSString, from: url)
        }
        return cache.object(forKey: url.absoluteString as NSString) ?? UIImage(named: self.placeHolderImage)!.resizeImage()
    }
    
    final private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    final private func downloadImage(_ key: NSString, from url: URL) {
        getData(from: url) { [weak self] data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                if let image = UIImage(data: data) {
                    self?.cache.setObject(image.resizeImage(), forKey: key)
                }
            }
        }
    }
}
