//
//  MyView.swift
//  KindOfADrag
//
//  Created by Gene De Lisa on 9/2/14.
//  Copyright (c) 2014 Gene De Lisa. All rights reserved.
//

import UIKit

class MyView: UIView {
    
    var fillColor = UIColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0).cgColor
    
    var boundingBoxColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0).cgColor
    
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            context.saveGState()
            defer {
                context.restoreGState()
            }
            
            context.clear(rect)
            
            let viewWidth = self.bounds.width
            let viewHeight = self.bounds.height
            
            context.setFillColor(fillColor)
            context.fill(CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))
            
            context.setStrokeColor(boundingBoxColor)
            context.setLineWidth(1.0)
            context.stroke(self.bounds)
        }
    }
    
}
