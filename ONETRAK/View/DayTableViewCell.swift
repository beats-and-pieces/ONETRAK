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
    
    
    //    override func layoutSubviews() {
    //        super.layoutSubviews()
    //        //set the values for top,left,bottom,right margins
    //        let margins = UIEdgeInsetsMake(10, 0, 0, 0)
    //        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, margins)
    //    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1
//        let color = UIColor(rgb: 0xFFFFFF, a: 1).cgColor
//        self.layer.borderColor = color
        self.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, a: 0.1).cgColor
     //   self.layer.cornerRadius = 10
        // Initialization code
    }
}
