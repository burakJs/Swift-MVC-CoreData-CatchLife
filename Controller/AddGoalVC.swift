//
//  AddGoalVC.swift
//  CatchLife
//
//  Created by Burak İmdat on 10.09.2021.
//

import UIKit

class AddGoalVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var txtGoal: UITextView!
    @IBOutlet weak var btnLongTerm: UIButton!
    @IBOutlet weak var btnMediumTerm: UIButton!
    @IBOutlet weak var btnShortTerm: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    var goalType: GoalTypes = .LongTerm
    let txtBaseGoal: String = "You can describe the goal you want to achieve"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtGoal.delegate = self
        btnNext.keyboardNotification()
        btnLongTerm.selectedButtonBGColor()
        btnMediumTerm.nonSelectedButtonBGColor()
        btnShortTerm.nonSelectedButtonBGColor()
    }
    

    @IBAction func btnLongTermClicked(_ sender: UIButton) {
        goalType = .LongTerm
        btnLongTerm.selectedButtonBGColor()
        btnMediumTerm.nonSelectedButtonBGColor()
        btnShortTerm.nonSelectedButtonBGColor()
    }
    @IBAction func btnMediumTermClicked(_ sender: UIButton) {
        goalType = .MediumTerm
        btnLongTerm.nonSelectedButtonBGColor()
        btnMediumTerm.selectedButtonBGColor()
        btnShortTerm.nonSelectedButtonBGColor()
    }
    @IBAction func btnShortTermClicked(_ sender: Any) {
        goalType = .ShortTerm
        btnLongTerm.nonSelectedButtonBGColor()
        btnMediumTerm.nonSelectedButtonBGColor()
        btnShortTerm.selectedButtonBGColor()
    }
    @IBAction func btnNextClicked(_ sender: UIButton) {
        if !txtGoal.text.isEmpty && txtGoal.text != txtBaseGoal {
            guard let createGoalVC = storyboard?.instantiateViewController(identifier: "createGoalVC") as? CreateGoalVC else { return }
            createGoalVC.setGoalParams(goal: txtGoal.text, type: goalType)
            presentingViewController?.presentCustomtoHome(createGoalVC)
        }
        
    }
    @IBAction func btnBackClicked(_ sender: UIButton) {
        dismissCustom()
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        txtGoal.text = ""
        txtGoal.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
