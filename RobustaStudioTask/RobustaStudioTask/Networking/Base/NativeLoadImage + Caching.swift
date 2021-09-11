//
//  NativeFetchImage.swift
//  RobustaStudioTask
//
//  Created by ahmed moharam on 11/09/2021.
//

import Foundation
import UIKit
import Combine

let imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoader: UIImageView {

    //MARK: - Properties
    var imageURL: URL?
    let activityIndicator = UIActivityIndicatorView()
    
    //MARK: - Methods
    func loadImageWithUrl(_ url: URL) {
        
        // setup image Loader...
        activityIndicator.color = .darkGray
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageURL = url
        image = nil
        activityIndicator.startAnimating()
        
        // retrieves image if already available in cache
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            activityIndicator.stopAnimating()
            return
        }
        
        //MARK: - API CALL
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            guard let self = self else { return }
            if error != nil {
                print(error as Any)
                DispatchQueue.main.async(execute: { [weak self] in
                    self?.activityIndicator.stopAnimating()
                })
                return
            }

            DispatchQueue.main.async(execute: { [weak self] in
                guard let self = self else { return }
                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                    if self.imageURL == url { self.image = imageToCache }
                    imageCache.setObject(imageToCache, forKey: url as AnyObject)
                }
                self.activityIndicator.stopAnimating()
            })
        }).resume()
    }
}
