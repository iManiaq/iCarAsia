//
//  NSDictionary+Look.swift
//  iCarAsia
//
//  Created by Sachin on 22/01/17.
//  Copyright © 2017 sachin. All rights reserved.
//

import Foundation
import UIKit

extension NSDictionary {
    
    var jsonString: String {
        var stringJson = ""
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(self, options: NSJSONWritingOptions.PrettyPrinted)
            stringJson = NSString(data: jsonData, encoding: NSUTF8StringEncoding)! as String
        } catch {
            
        }
        return stringJson
    }

    
}