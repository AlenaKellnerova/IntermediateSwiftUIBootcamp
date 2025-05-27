//
//  ImageModelCacheManager.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 27.05.2025.
//

import Foundation
import SwiftUI

class ImageModelCacheManager {
    
    static let instance = ImageModelCacheManager()
    private init() { }
    
    var imageCache: NSCache<NSString, UIImage> = {
       var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.countLimit = 1024 * 1024 * 200 // 200MB
        return cache
    }()
    
    // id
    func addImageToCache(key: String, value: UIImage) {
        imageCache.setObject(value, forKey: key as NSString)
    }
    
    // id
    func getImageFromCache(key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }
    
}
