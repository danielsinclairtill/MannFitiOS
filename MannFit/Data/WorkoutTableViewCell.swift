//
//  WorkoutTableViewCell.swift
//  MannFit
//
//  Created by Luis Abraham on 2017-12-29.
//  Copyright © 2017 MannFit Labs. All rights reserved.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {

    @IBOutlet weak var workoutImageView: UIImageView!
    @IBOutlet weak var workoutNameLabel: UILabel!
    @IBOutlet weak var workoutDateLabel: UILabel!
    @IBOutlet weak var workoutScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(workoutItem: WorkoutItem) {
        self.workoutNameLabel.text = workoutItem.game
        self.workoutScoreLabel.text = workoutItem.formattedAbsementScore
        self.workoutImageView.image = workoutItem.gameImage
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.workoutDateLabel.text = dateFormatter.string(from: workoutItem.date)
    }

}
