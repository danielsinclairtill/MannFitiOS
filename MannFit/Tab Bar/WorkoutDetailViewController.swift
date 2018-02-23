//
//  WorkoutDetailViewController.swift
//  MannFit
//
//  Created by Luis Abraham on 2018-02-23.
//  Copyright © 2018 MannFit Labs. All rights reserved.
//

import UIKit

class WorkoutDetailViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var workoutImageView: UIImageView!
    @IBOutlet weak var workoutNameLabel: UILabel!
    @IBOutlet weak var absementScoreLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!

    var workoutName: String!
    var absementScore: String!
    var date: Date!
    var duration: Int64!
    var workoutGameImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workoutImageView.image = workoutGameImage
        workoutNameLabel.text = workoutName
        absementScoreLabel.text = absementScore
        durationLabel.text = String(format: "%ds", duration)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMM d"
        self.title = dateFormatter.string(from: date)
    }

}
