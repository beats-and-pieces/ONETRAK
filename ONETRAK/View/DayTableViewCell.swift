//
//  DayTableViewCell.swift
//  ONETRAK
//
//  Created by Anton Kuznetsov on 27/12/2018.
//  Copyright © 2018 Anton Kuznetsov. All rights reserved.
//

import UIKit
import CoreGraphics

class DayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalStepsLabel: UILabel!
    
    @IBOutlet weak var progressBarView: ProgressBarView!
    
    @IBOutlet weak var walkStepsLabel: UILabel!
    @IBOutlet weak var aerobicStepsLabel: UILabel!
    @IBOutlet weak var runStepsLabel: UILabel!
    
    @IBOutlet weak var goalAchievedBar: UIStackView!
    @IBOutlet weak var achievementStar: UIImageView!
    
    @IBOutlet weak var upperBorder: UIView!
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 4
            frame.size.height -= 2 * 5
            super.frame = frame
            self.layoutSubviews()
        }
    }
}
