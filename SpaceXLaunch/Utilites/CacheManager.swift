//
//  CacheManager.swift
//  SpaceXLaunch
//
//  Created by MM on 24.11.2022.
//

import SwiftUI

class CacheManager {
    
    static let share = CacheManager()
    private init() { }
    
    var cache: NSCache<NSString,UIImage> {
        let cache = NSCache<NSString,UIImage>()
        cache.countLimit = 10
        cache.totalCostLimit = 1024*1024*20
        return cache
    }
    
    func addItem(name: String, image: UIImage) {
        cache.setObject(image, forKey: name as NSString)
    }
    
    func getItem(name: String) -> UIImage? {
        cache.object(forKey: name as NSString)
    }
}
