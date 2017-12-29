//
//  CoreDataContract.swift
//  MannFit
//
//  Created by Luis Abraham on 2017-11-23.
//  Copyright © 2017 MannFit Labs. All rights reserved.
//

import UIKit
import CoreData

protocol CoreDataCompliant: class {
    var managedObjectContext: NSManagedObjectContext! { get set }
}

extension CoreDataCompliant where Self: UIViewController { }
