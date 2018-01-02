//
//  WorkoutHistoryViewController.swift
//  MannFit
//
//  Created by Luis Abraham on 2017-12-28.
//  Copyright © 2017 MannFit Labs. All rights reserved.
//

import UIKit
import CoreData

class WorkoutHistoryViewController: UITableViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    
    private lazy var fetchedResultsController: NSFetchedResultsController<WorkoutItem> = {
        let fetchRequest: NSFetchRequest<WorkoutItem> = WorkoutItem.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        return NSFetchedResultsController(fetchRequest: fetchRequest,
                                          managedObjectContext: self.managedObjectContext,
                                          sectionNameKeyPath: nil,
                                          cacheName: nil)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            // TODO: Handle the error cleanly
            print(error)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.tableView.reloadData()
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.WorkoutCell, for: indexPath) as! WorkoutTableViewCell
        
        let item = self.fetchedResultsController.object(at: indexPath)
        
        cell.configureCell(workoutItem: item)
        
        return cell
    }
}

// MARK: - CoreDataCompliant
extension WorkoutHistoryViewController: CoreDataCompliant {
    
}

