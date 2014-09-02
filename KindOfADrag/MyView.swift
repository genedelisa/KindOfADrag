//
//  MyView.swift
//  KindOfADrag
//
//  Created by Gene De Lisa on 9/2/14.
//  Copyright (c) 2014 Gene De Lisa. All rights reserved.
//

import UIKit

class MyView: UIView {
    var fillColor = UIColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0).CGColor
    var boundingBoxColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0).CGColor
    
    override func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        CGContextClearRect(context, rect)
        
        let viewWidth = CGRectGetWidth(self.bounds)
        let viewHeight = CGRectGetHeight(self.bounds)
        
        CGContextSetFillColorWithColor(context, fillColor)
        CGContextFillRect(context, CGRectMake(0, 0, viewWidth, viewHeight))
        
        CGContextSetStrokeColorWithColor(context, boundingBoxColor)
        CGContextSetLineWidth(context, 1.0)
        CGContextStrokeRect(context, self.bounds)
    }

}
