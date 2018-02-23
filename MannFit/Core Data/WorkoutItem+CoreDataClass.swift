//
//  WorkoutItem+CoreDataClass.swift
//  MannFit
//
//  Created by Luis Abraham on 2017-11-23.
//  Copyright © 2017 MannFit Labs. All rights reserved.
//
//

import UIKit
import CoreData

public class WorkoutItem: NSManagedObject {

}

extension WorkoutItem {
    
    var formattedAbsementScore: String {
        return String(format: "%.2f", self.absement)
    }
    
    var gameImage: UIImage? {
        return UIImage(named: self.game)
    }
}
