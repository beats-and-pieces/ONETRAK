//
//  GoalViewController.swift
//  ONETRAK
//
//  Created by Anton Kuznetsov on 28/12/2018.
//  Copyright © 2018 Anton Kuznetsov. All rights reserved.
//

import UIKit

class GoalViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func submit(_ sender: UIButton) {
        if let steps = Int(textField.text!) {
            
            StatsData.goal = Goal(steps: steps)
            print("StatsData.goal.steps \(StatsData.goal.steps)")
            dismiss(animated: true, completion: nil)
        }
    }
    
//    func doneButtonAction()
//    {
//        //self.desription
//        self.textFieldShouldReturn(textField)
//        // self.textViewDescription.resignFirstResponder()
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//        //textField code
//
//        textField.resignFirstResponder()  //if desired
//        performAction()
//        return true
//    }
//
//    func performAction() {
//        if let steps = Int(textField.text!) {
//            StatsData.goal.steps = steps
//            dismiss(animated: true, completion: nil)
//        }
//        //action events
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  self.textField.delegate = self
        //  self.addDoneButtonOnKeyboard()
    }
    
    
}
