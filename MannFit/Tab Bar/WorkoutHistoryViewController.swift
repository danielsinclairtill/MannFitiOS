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
    
    struct DummyData {
        var score: Double
        var name: String
        var date: Date
    }
    
    var managedObjectContext: NSManagedObjectContext!
    
    var data: [DummyData] = {
        let item1 = DummyData(score: 4.65, name: "PacMan", date: Date())
        let item2 = DummyData(score: 6.16, name: "PacMan", date: Date())
        let item3 = DummyData(score: 7.21, name: "PacMan", date: Date())
        return [item1, item2, item3]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.black
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
        return data.count
    }
    
    // This will all be cleaned up in another commit
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.WorkoutCell, for: indexPath) as! WorkoutTableViewCell
        
        let item = data[indexPath.row]
        cell.workoutNameLabel.text = item.name
        cell.workoutScoreLabel.text = "\(String(format: "%.2f", item.score))"
        cell.workoutImageView.image = UIImage(named: item.name)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        cell.workoutDateLabel.text = dateFormatter.string(from: item.date)
        
        return cell
    }
}

// MARK: - CoreDataCompliant
extension WorkoutHistoryViewController: CoreDataCompliant {
    
}

