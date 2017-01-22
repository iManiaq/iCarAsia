//
//  UILabel+Look.swift
//  iCarAsia
//
//  Created by Sachin on 22/01/17.
//  Copyright © 2017 sachin. All rights reserved.
//

import UIKit

extension UILabel {
    
    func requiredHeight() -> CGFloat{
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, self.frame.width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = self.font
        label.text = self.text
        label.sizeToFit()
        return label.frame.height
    }
    
}

