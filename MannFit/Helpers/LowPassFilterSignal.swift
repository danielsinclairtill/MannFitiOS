//
//  LowPassFilterSignal.swift
//  MannFit
//
//  Created by Luis Abraham on 2017-11-27.
//  Copyright © 2017 MannFit Labs. All rights reserved.
//

import Foundation

struct LowPassFilterSignal {
    
    var value: Double
    
    let timeConstant: Double
    
    mutating func update(newValue: Double) {
        self.value = timeConstant * self.value + (1.0 - self.timeConstant) * newValue
    }
}
