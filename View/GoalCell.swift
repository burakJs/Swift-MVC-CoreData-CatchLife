//
//  GoalCell.swift
//  CatchLife
//
//  Created by Burak İmdat on 9.09.2021.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var lblGoal: UILabel!
    @IBOutlet weak var lblGoalType: UILabel!
    @IBOutlet weak var lblGoalRepeatCount: UILabel!
    
    @IBOutlet weak var completedView: UIView!
    
    func setView(goal: Goal) {
        lblGoal.text = goal.goal
        lblGoalType.text = goal.goalType
        lblGoalRepeatCount.text = String(goal.numberGoalCompleted)
        
        completedView.isHidden =  !(goal.goalRepeatCount == goal.numberGoalCompleted)
        
    }
}
