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
        myview.frame = CGRect(x: 10, y: 40, width: 40, height: 40)
        
        myview = MyView()
        view.addSubview(myview)
        myview.frame = CGRect(x: 60, y: 80, width: 40, height: 40)
        myview.fillColor = UIColor(red: 1.0, green: 0.5, blue: 1.0, alpha: 1.0).cgColor
        
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
    
    func pan(_ rec:UIPanGestureRecognizer) {
        
        let p:CGPoint = rec.location(in: self.view)
        var center:CGPoint = .zero
        
        switch rec.state {
        case .began:
            print("began")
            selectedView = view.hitTest(p, with: nil)
            if selectedView != nil {
                self.view.bringSubview(toFront: selectedView!)
            }
            
        case .changed:
            if let subview = selectedView {
                center = subview.center
                let distance = sqrt(pow((center.x - p.x), 2.0) + pow((center.y - p.y), 2.0))
                print("distance \(distance) threshold \(threshold)")
                
                if subview is MyView {
                    if distance > threshold {
                        if shouldDragX {
                            subview.center.x = p.x - (p.x.truncatingRemainder(dividingBy: snapX))
                        }
                        if shouldDragY {
                            subview.center.y = p.y - (p.y.truncatingRemainder(dividingBy: snapY))
                        }
                    }
                }
            }
            
        case .ended:
            print("ended")
            if let subview = selectedView {
                if subview is MyView {
                    // do whatever
                }
            }
            selectedView = nil
            
        case .possible:
            print("possible")
        case .cancelled:
            print("cancelled")
            selectedView = nil
        case .failed:
            print("failed")
            selectedView = nil
        }
    }
}

