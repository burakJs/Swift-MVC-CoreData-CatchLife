//
//  CreateGoalVC.swift
//  CatchLife
//
//  Created by Burak İmdat on 13.09.2021.
//

import UIKit

class CreateGoalVC: UIViewController {

    @IBOutlet weak var txtGoalCount: UITextField!
    @IBOutlet weak var btnCreateGoal: UIButton!
    var txtGoal: String = ""
    var goalType: GoalTypes = .LongTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnCreateGoal.keyboardNotification()
    }
    
    func setGoalParams(goal: String, type: GoalTypes) {
        txtGoal = goal
        goalType = type
    }
   

    
    @IBAction func bntBackClicked(_ sender: UIButton) {
        dismissCustom()
    }
    @IBAction func btnCreateGoalClicked(_ sender: UIButton) {
        if txtGoalCount.text != "" && Int(txtGoalCount.text!)! > 0 {
            self.save { success in
                if success {
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func save(completionHandler: (_ isSuccess: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: managedContext)
        
        goal.goalRepeatCount = Int32(txtGoalCount.text!)!
        goal.goalType = goalType.rawValue
        goal.goal = txtGoal
        goal.numberGoalCompleted = Int32(0)
        
        do {
            try managedContext.save()
            completionHandler(true)
        } catch {
            debugPrint("ERROR: \(error.localizedDescription)")
            completionHandler(false)
        }
    }
}
