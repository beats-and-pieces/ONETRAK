//
//  DaysViewController.swift
//  ONETRAK
//
//  Created by Anton Kuznetsov on 27/12/2018.
//  Copyright © 2018 Anton Kuznetsov. All rights reserved.
//
import UIKit

class DaysViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var days = [Day]() {
        didSet {
            DispatchQueue.main.async {
                if self.days.count > 0 {
                    self.tableView.reloadData()
                    self.introAnimation()
                } else {
                    self.tableView.isHidden = true
                    self.tableView.backgroundView?.isHidden = false
                }
            }
        }
    }
    
    var goal = Goal(steps: 4000) {
        didSet {
            updateUI()
        }
    }
    
    var animateProgressBars = true
    var animateAchievementStars = true
    
    @IBOutlet weak var tableView: UITableView!
    
    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell  = tableView.dequeueReusableCell(withIdentifier: "DayCell") as? DayTableViewCell {
            if !days.isEmpty {
                let day = days[indexPath.row]
                cell.dateLabel.text = day.date.formattedDateFromUnixTime()
                cell.totalStepsLabel.text = "\(day.total) / \(goal.steps) steps"
                cell.walkStepsLabel.text = "\(day.walk)"
                cell.aerobicStepsLabel.text = "\(day.aerobic)"
                cell.runStepsLabel.text = "\(day.run)"
                cell.progressBarView.shapeLayer?.removeAllAnimations()
                cell.progressBarView.drawBarsFor(walk: day.proportionWalk, aerobic: day.proportionAerobic, run: day.proportionRun, animated: animateProgressBars)
                if day.total >= goal.steps {
                    if animateAchievementStars {
                        cell.goalAchievedBar.isHidden = false
                        cell.goalAchievedBar.alpha = 1
                        cell.achievementStar.alpha = 0
                        UIView.animate(withDuration: 1.5, delay: 0.2, options: [], animations: {
                            cell.achievementStar.alpha = 1
                        }, completion: nil)
                    }
                } else {
                    cell.goalAchievedBar.isHidden = true
                }
                cell.layoutSubviews()
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if days.count > 0 {
            return 1
        } else {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
            
            messageLabel.text = "Loading..."
            messageLabel.textColor = UIColor.black
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.sizeToFit()
            
            self.tableView.backgroundView = messageLabel
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            
            return 0
        }
    }

    func getAllData() {
        StatsData.getFromServer { (days, error) in
            if let error = error {
                print(error)
                return
            }
            guard let days = days else {
                print("error getting days: result is nil")
                return
            }
            self.days = days
    
            if let goal = StatsData.getGoalFromDisk() {
                self.goal = goal
            }
            print("self.goal \(self.goal.steps)")
        }
    }
    
    func introAnimation() {
        self.tableView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            self.tableView.alpha = 1
        }, completion: nil)
        self.tableView.backgroundView?.isHidden = true
    }
    
    override func viewDidLoad() {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        super.viewDidLoad()
        getAllData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("View appeared!")
        animateAchievementStars = true
        self.goal = StatsData.goal
        super.viewDidAppear(animated)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if animateProgressBars == true {
            animateProgressBars = false
        }
        if animateAchievementStars == true {
            animateAchievementStars = false
        }
    }
}

extension Int {
    func formattedDateFromUnixTime() -> String {
        let date = Date(timeIntervalSince1970: Double(self / 1000))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d.MM.yyyy"
        return dateFormatter.string(from: date)
    }
}


