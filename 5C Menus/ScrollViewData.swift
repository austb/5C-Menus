//
//  ScrollViewData.swift
//  5C Menus
//
//  Created by Austin Blatt on 10/1/14.
//  Copyright (c) 2014 Austin Blatt. All rights reserved.
//

import Foundation

class ScrollViewData: NSObject {
    var pageIndex : NSNumber!
    let pageTitles : [NSString]!
    
    func getPageTitle() -> NSString {
        let pageTitle : NSString = self.pageTitles[self.pageIndex!.integerValue]
        return pageTitle
    }
    
    override init() {
        if(NSUserDefaults.standardUserDefaults().valueForKey("current_dining_hall") == nil) {
            pageIndex = 0
        } else {
            pageIndex = (NSUserDefaults.standardUserDefaults().valueForKey("current_dining_hall") as NSNumber)
        }
        pageTitles = ["Frank", "Frary", "Collins", "Scripps", "Pitzer", "Harvey Mudd"]
    }
}