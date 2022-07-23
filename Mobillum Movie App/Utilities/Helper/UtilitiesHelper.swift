//
//  UtilitiesHelper.swift
//  Mobillum Movie App
//
//  Created by Ali Han Demir on 22.07.2022.
//

import Foundation
import SDWebImage

class UtilitiesHelper{
 
    class func clearImageCache() {
        let imageCache = SDImageCache.shared
        imageCache.clearMemory()
    }
    
    class func configImageCache() {
        let imageCache = SDImageCache.shared
        imageCache.config.shouldCacheImagesInMemory = false
        
        imageCache.config.maxMemoryCost = 1024 * 1024 * 1
        imageCache.config.maxDiskAge = 3600 * 24 * 7 //1 week to hold images in cache
        imageCache.config.diskCacheReadingOptions = NSData.ReadingOptions.mappedIfSafe
        
        SDWebImageManager.shared.cacheSerializer = nil
    }
    
    class func fromStringToDate(release_dateStr:String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: release_dateStr)
        return date ?? Date()
    }
    
    class func fromDateToYear(date:Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: date)
        return yearString
    }
    
    class func fromStringToDateWithDots(release_dateStr:Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.string(from: release_dateStr)
        return date
    }
}
