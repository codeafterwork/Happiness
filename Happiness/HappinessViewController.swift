//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Tomas on 23/01/16.
//  Copyright © 2016 Codeafterwork. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource {

    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
        }
    }
    
    private struct Constants {
        static let HappinessGestureScale: CGFloat = 4
    }
    
    @IBAction func changeHappiness(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = sender.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                sender.setTranslation(CGPointZero, inView: faceView)
            }
        default: break
        }
    }
    
    var happiness: Int = 10 { // 0 = very sad, 100 = ecstatic
        didSet {
            happiness = min(max(happiness, 0), 100)
            print("happiness: \(happiness)")
            updateUI()
        }
    }
    
    func updateUI() {
        faceView.setNeedsDisplay()
    }
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness-50)/50.0
    }
}
