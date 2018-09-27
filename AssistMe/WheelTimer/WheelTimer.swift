//
//  WheelTimer.swift
//  AssistMe
//
//  Created by David Doswell on 9/26/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class WheelTimer {
    
    var timer: Timer!
    
    func beginTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(begin), userInfo: nil, repeats: true)
    }
    
    @objc func begin() {
       // begin sending notifications
    }
    
    @objc func end() {
        timer.invalidate()
    }
}
