//
//  GoalListVC.swift
//  CatchLife
//
//  Created by Burak İmdat on 9.09.2021.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var goalList: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        loadData() //ERROR: ÇALIŞMIYOR
    }
    
    func loadData(){
        getData { success in
             tableView.isHidden = !(success && goalList.count >= 1)
        }
        tableView.reloadData()
    }
    @IBAction func btnAddClicked(_ sender: UIButton) {
        guard let addGoalVC = storyboard?.instantiateViewController(identifier: "AddGoalVC") else { return }
        presentCustom(addGoalVC)
    }
    @IBAction func updateGoalListManual(_ sender: UIButton) {
        self.loadData()
    }
}

extension GoalListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goalList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else { return UITableViewCell() }
        let presentGoal = goalList[indexPath.row]
        cell.setView(goal: presentGoal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "DELETE GOAL"){ action, view, boolValue in
            self.deleteData(indexPath: indexPath)
            self.loadData()
        }
        
        let update = UIContextualAction(style: .normal, title: "UPDATE GOAL"){ action, view, boolValue in
            debugPrint("UPDATE")
            self.goalUpdate(indexPath: indexPath)
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
            
        update.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        let swipeActions = UISwipeActionsConfiguration(actions: [delete, update])

        return swipeActions
   }
}


extension GoalListVC {
    
    func goalUpdate(indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let selectedGoal = goalList[indexPath.row]
        debugPrint(selectedGoal.goalRepeatCount)
        debugPrint(selectedGoal.numberGoalCompleted)
        if selectedGoal.numberGoalCompleted < selectedGoal.goalRepeatCount {
            selectedGoal.numberGoalCompleted += 1
        } else {
            return
        }
        
        do {
            try managedContext.save()
            print("UPDATE IS SUCCESS")
        } catch {
            debugPrint("ERROR: \(error)")
        }
    }
    
    func getData(completionHandler: (_ isSuccess: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            goalList = try managedContext.fetch(fetchRequest)
            print("Datas is OK")
            completionHandler(true)
        } catch {
            debugPrint("Has error : \(error.localizedDescription)")
            completionHandler(false)
        }
    }
    
    func deleteData(indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        managedContext.delete(goalList[indexPath.row])
        
        do {
            try managedContext.save()
            self.goalList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        } catch {
            debugPrint("Has error : \(error.localizedDescription)")
        }
    }
}
