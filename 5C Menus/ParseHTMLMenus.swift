//
//  ParseHTMLMenus.swift
//  5C Menus
//
//  Created by Austin Blatt on 10/3/14.
//  Copyright (c) 2014 Austin Blatt. All rights reserved.
//

import Foundation

class ParseHTMLMenus : NSObject {
    var arrayOfMenuItems : NSArray!
    var didURLRetrievalSucceed : Bool!
    
    override init() {
        super.init()
        let url : NSURL = NSURL(string: "http://aspc.pomona.edu/menu/")!
        
        // Get String of HTML from url
        var err = NSErrorPointer()
        var str : String! = NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding, error: err)
        
        // If URL retrieval fails, try it a few more times
        if (str == nil) {
            for var i = 0; i < 20; i++ {
                // Attempt to get HTTP string
                str = NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding, error: err)
                
                // If a str is returned do not call again
                if str != nil {
                    break
                }
            }
        }
        
        if str != nil {
            
            // Normalize string by replacing " with ', removing tabs, newlines, and extra spaces.
            str = str.stringByReplacingOccurrencesOfString("\"", withString: "'")
            str = str.stringByReplacingOccurrencesOfString("\t", withString: "")
            str = str.stringByReplacingOccurrencesOfString("\n", withString: "")
            
            // regex removes all extra spaces and replaces them with a single space (only single spaces will remain)
            let regex = NSRegularExpression(pattern: "  +", options: NSRegularExpressionOptions.CaseInsensitive, error: err)
            str = regex!.stringByReplacingMatchesInString(str, options:NSMatchingOptions.allZeros, range: NSMakeRange(0, countElements(str)), withTemplate: "" )
            
            //
            var array : NSArray = str.componentsSeparatedByString("<table id='day_nav'>")
            array = array[1].componentsSeparatedByString("</table></section>")
            str = (array[0] as String)
            
            var menuStrings : NSMutableArray! = NSMutableArray()
            
            // Adds Frank Menu String
            menuStrings.addObject((str.componentsSeparatedByString("<tr id='frank_menu'>")[1]).componentsSeparatedByString("<tr id='frary_menu'>")[0] as String)
            
            // Adds Frary Menu String
            menuStrings.addObject(((str.componentsSeparatedByString("<tr id='frary_menu'>")[1]).componentsSeparatedByString("<tr id='cmc_menu'>")[0]).componentsSeparatedByString("<tr id='oldenborg_menu'>")[0] as String)
            
            // Adds CMC Menu String
            menuStrings.addObject((str.componentsSeparatedByString("<tr id='cmc_menu'>")[1]).componentsSeparatedByString("<tr id='scripps_menu'>")[0] as String)
            
            // Adds Scripps Menu String
            menuStrings.addObject((str.componentsSeparatedByString("<tr id='scripps_menu'>")[1]).componentsSeparatedByString("<tr id='pitzer_menu'>")[0] as String)
            
            // Adds Pitzer Menu String
            menuStrings.addObject((str.componentsSeparatedByString("<tr id='pitzer_menu'>")[1]).componentsSeparatedByString("<tr id='mudd_menu'>")[0] as String)
            
            // Adds Mudd Menu String
            menuStrings.addObject((str.componentsSeparatedByString("<tr id='mudd_menu'>")[1]) as String)
            
            var menuArray : NSMutableArray! = NSMutableArray()
            
            for menuString in menuStrings {
                menuArray.addObject(parseMenuString(menuString as String))
            }
            
            self.arrayOfMenuItems = menuArray
            self.didURLRetrievalSucceed = true
            
        } else {
            // URL retrieval failed, probably because of lack of internet connection
            self.didURLRetrievalSucceed = false
            // Set up failed to retrieve menu message
            self.arrayOfMenuItems = [[["Failed to retrieve menu."],["Failed to retrieve menu."],["Failed to retrieve menu."]],[["Failed to retrieve menu."],["Failed to retrieve menu."],["Failed to retrieve menu."]],[["Failed to retrieve menu."],["Failed to retrieve menu."],["Failed to retrieve menu."]],[["Failed to retrieve menu."],["Failed to retrieve menu."],["Failed to retrieve menu."]],[["Failed to retrieve menu."],["Failed to retrieve menu."],["Failed to retrieve menu."]],[["Failed to retrieve menu."],["Failed to retrieve menu."],["Failed to retrieve menu."]]]
        }
        
    
    }
    
    func parseMenuString(string: String) -> NSArray {
        var arrayOfMealStrings = string.componentsSeparatedByString("<span class='mobile_meal_header'>")
        var halfwayArray = NSArray()
        var returnArrayBuilder = NSMutableArray()
        var returnArray = NSMutableArray()
        
        // Loops through array indexes 1-3 (don't want #1)
        for var i = 1; i < arrayOfMealStrings.count; i++ {
            halfwayArray = NSArray()
            returnArrayBuilder = NSMutableArray()
            halfwayArray = (arrayOfMealStrings[i].componentsSeparatedByString("li>"))
            
            // Only want to loop through the odd indexed Strings
            var tmpStr : String!
            for var i = 1; i < halfwayArray.count; i+=2 {
                
                // Remove leading </food Item
                tmpStr = halfwayArray[i].componentsSeparatedByString("</")[0] as String
                // Remove and trailing/leading whitespace and newlines
                tmpStr = tmpStr.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                // Replace &amp; with &, &#39; with ', etc.
                tmpStr = self.removeHTMLEncodingFromString(tmpStr)
                
                // Add fully editted menu item string to array
                returnArrayBuilder.addObject(tmpStr)
            }
            
            returnArray.addObject(returnArrayBuilder)
        }
        
        return NSArray(array: returnArray)
    }
    
    func removeHTMLEncodingFromString(str: String) -> String {
        var tmp : String = str
        
        tmp = tmp.stringByReplacingOccurrencesOfString("&amp;", withString: "&")
        tmp = tmp.stringByReplacingOccurrencesOfString("&#39;", withString: "'")
        
        return tmp
    }

}