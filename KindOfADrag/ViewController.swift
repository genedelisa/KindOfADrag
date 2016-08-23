//
//  ViewController.swift
//  KindOfADrag
//
//  Created by Gene De Lisa on 9/2/14.
//  Copyright (c) 2014 Gene De Lisa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /// must be >= 1.0
    var snapX:CGFloat = 40.0
    
    /// must be >= 1.0
    var snapY:CGFloat = 1.0
    
    /// how far to move before dragging
    var threshold:CGFloat = 0.0
    
    /// the guy we're dragging
    var selectedView:UIView?
    
    /// drag in the Y direction?
    var shouldDragY = true
    
    /// drag in the X direction?
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
        let pan = UIPanGestureRecognizer(target:self, action:#selector(ViewController.pan(_:)))
        pan.maximumNumberOfTouches = 1
        pan.minimumNumberOfTouches = 1
        self.view.addGestureRecognizer(pan)
    }
    
    func pan(rec:UIPanGestureRecognizer) {
        
        let p:CGPoint = rec.locationInView(self.view)
        var center:CGPoint = CGPointZero
        
        switch rec.state {
        case .Began:
            print("began")
            selectedView = view.hitTest(p, withEvent: nil)
            if selectedView != nil {
                self.view.bringSubviewToFront(selectedView!)
            }
            
        case .Changed:
            if let subview = selectedView {
                center = subview.center
                let distance = sqrt(pow((center.x - p.x), 2.0) + pow((center.y - p.y), 2.0))
                print("distance \(distance)")
                
                if subview is MyView {
                    if distance > threshold {
                        if shouldDragX {
                            subview.center.x = p.x - (p.x % snapX)
                        }
                        if shouldDragY {
                            subview.center.y = p.y - (p.y % snapY)
                        }
                    }
                }
            }
            
        case .Ended:
            print("ended")
            if let subview = selectedView {
                if subview is MyView {
                    // do whatever
                }
            }
            selectedView = nil
            
        case .Possible:
            print("possible")
        case .Cancelled:
            print("cancelled")
        case .Failed:
            print("failed")
        }
    }
}

