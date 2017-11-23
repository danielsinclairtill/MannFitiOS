//
//  CoreDataWrapper.swift
//  MannFit
//
//  Created by Luis Abraham on 2017-11-23.
//  Copyright © 2017 MannFit Labs. All rights reserved.
//

import Foundation
import CoreData

class CoreDataWrapper {
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MannFit")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            // Kill the application if we have an error (we can't operate without storing, something went wrong)
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error)")
            }
        })
        
        return container
    }()
    
    // Context which contains all of the changes to our model
    lazy var managedObjectContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
}

extension NSManagedObjectContext {
    // Safely save changes to object context
    func saveChanges() {
        if self.hasChanges {
            do {
                try save()
            } catch {
                // Kill the program if we can't save, something went wrong
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}
