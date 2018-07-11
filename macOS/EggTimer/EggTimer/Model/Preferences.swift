//
//  Preferences.swift
//  EggTimer
//
//  Created by xin on 2018/2/1.
//  Copyright © 2018年 lgy. All rights reserved.
//

import Foundation

struct Preferences {
    
    var selectedTime: TimeInterval {
        get {
            let savedTime = UserDefaults.standard.double(forKey: "selectedTime")
            if savedTime > 0 {
                return savedTime
            }
            
            return 360
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "selectedTime")
        }
    }
}
