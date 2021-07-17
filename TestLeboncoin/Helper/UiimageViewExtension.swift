//
//  UiimageViewExtension.swift
//  TestLeboncoin
//
//  Created by walid nakbi on 15/7/2021.
//

import UIKit
var imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  //
        if let cacheImage = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = cacheImage
            return
        }
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            imageCache.setObject(image, forKey: url as AnyObject)
            
           
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
}

