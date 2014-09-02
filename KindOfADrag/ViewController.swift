//
//  ViewController.swift
//  KindOfADrag
//
//  Created by Gene De Lisa on 9/2/14.
//  Copyright (c) 2014 Gene De Lisa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var snapX:CGFloat = 40.0
    var snapY:CGFloat = 40.0
    var threshold:CGFloat = 0.0
    var selectedView:UIView?
    var shouldDragY = true
    var shouldDragX = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var myview = MyView()
        view.addSubview(myview)
        myview.frame = CGRectMake(10, 40, 40, 40)
        
        myview = MyView()
        view.addSubview(myview)
        myview.frame = CGRectMake(60, 80, 40, 40)
        myview.fillColor = UIColor(red: 1.0, green: 0.5, blue: 1.0, alpha: 1.0).CGColor
        
        setupGestures()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupGestures() {
        var pan = UIPanGestureRecognizer(target:self, action:"pan:")
        pan.maximumNumberOfTouches = 1
        pan.minimumNumberOfTouches = 1
        self.view.addGestureRecognizer(pan)
    }
    
    func pan(rec:UIPanGestureRecognizer) {
        
        var p:CGPoint = rec.locationInView(self.view)
        var center:CGPoint = CGPointZero
        
        switch rec.state {
        case .Began:
            println("began")
            selectedView = view.hitTest(p, withEvent: nil)
            if selectedView != nil {
                self.view.bringSubviewToFront(selectedView!)
            }
            
        case .Changed:
            if let subview = selectedView {
                center = subview.center
                var distance = sqrt(pow((center.x - p.x), 2.0) + pow((center.y - p.y), 2.0))
                println("distance \(distance)")
                
                if subview is MyView {
                    if distance > threshold {
                        if shouldDragX {
                            subview.center.x = p.x - (p.x % snapX)
                        }
                        if shouldDragY {
                            subview.center.y = p.y - (p.y % snapY)
                        }
                    }
                } else {
                    println("no selected subview \(subview)")
                    return
                }
            }
            
        case .Ended:
            println("ended")
            if let subview = selectedView {
                if subview is MyView {
                    // do whatever
                }
            }
            selectedView = nil
            
        case .Possible:
            println("possible")
        case .Cancelled:
            println("cancelled")
        case .Failed:
            println("failed")
        }
    }
}

