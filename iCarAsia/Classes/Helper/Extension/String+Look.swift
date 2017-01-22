//
//  String+Look.swift
//  iCarAsia
//
//  Created by Sachin on 22/01/17.
//  Copyright © 2017 sachin. All rights reserved.
//

import Foundation
import UIKit


extension String {
    
    func requiredHeight(font: UIFont,width: CGFloat ) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRectMake(0, 0,width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = font
        label.text = self
        label.sizeToFit()
        return label.frame.height
    }
    
    var trimmedString: String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    var isPhoneNumber:  Bool {
        let mobile = "^\\+[0-9'@s]{11,11}$"
        let range = self.rangeOfString(mobile, options:.RegularExpressionSearch)
        let result = range != nil ? true : false
        return result
    }
    
    public var isCarListUrl: Bool {
        var result = false
        if NSURL(string: self) != nil {
            if self.containsString("carlist.my") {
                result = true
            }
        }
        return result
    }
    
    var isUrl: Bool {
        var result = false
        if self.hasPrefix("http://") || self.hasPrefix("https://") {
            result = true
        }
        return result
    }
    
    var processedString: String {
        var processed:String = ""
        let processedDictionary = NSMutableDictionary()
        let components = self.componentsSeparatedByCharactersInSet(.whitespaceCharacterSet())
        for component in components {
            if component.isPhoneNumber {
                processed = processed + " ************"
            } else if component.isUrl {
                if component.isCarListUrl {
                    processed = processed + " " + component
                    processedDictionary["“Links”"] = [["url": component],["title": component.titleForHTML] ]
                    
                } else {
                    processed = processed + " *****"
                }
            } else {
                processed = processed + " " + component
            }
        }
        processedDictionary["message"] = [processed]
        
        return processedDictionary.jsonString
    }
    
    var titleForHTML : String {
        var title = ""
        if let url = NSURL(string: self) {
            do {
                let htmlCode = try NSString(contentsOfURL: url, encoding: NSASCIIStringEncoding)
                let startPoint = "<title>"
                let endPoint = "</title>"
                if let htmlSteing = htmlCode as? String , let htmlTitle = htmlSteing.sliceString(startPoint, to: endPoint) {
                    title = htmlTitle
                }
            }
            catch {
                print("failed")
            }
        }
        return title
    }
    
    public func sliceString(start: String, to: String) -> String? {
        return (rangeOfString(start)?.endIndex).flatMap { sInd in
            (rangeOfString(to, range: sInd..<endIndex)?.startIndex).map { eInd in
                substringWithRange(sInd..<eInd)
            }
        }
    }
    
    
}