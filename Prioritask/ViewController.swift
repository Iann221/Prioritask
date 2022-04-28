//
//  ViewController.swift
//  Prioritask
//
//  Created by Vincentius Ian Widi Nugroho on 27/04/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var taskTable: UITableView!
    @IBOutlet weak var addTaskButton: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var taskList = [Task]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getAllTasks()
        self.title = "Your Tasks"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllTasks()
    }
    
    @IBAction func addTaskClick(_ sender: Any) {
//        createTask(name: "mymom", time: "asdfmka", completed: true, importance: "asdfsad", urgency: 1)
    }
    
    @IBAction func unwindSegue(_ sender: UIStoryboardSegue){
        
    }
    
    // function tasks table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currTask = taskList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "task cell", for: indexPath) as! TaskTableCell
        cell.taskName.text = currTask.name
        cell.taskTime.text = currTask.time
        if(currTask.importance == "high"){
            cell.taskImportance.image = (UIImage(named: "redCircle.png"))
        } else if(currTask.importance == "medium"){
            cell.taskImportance.image = (UIImage(named: "orangeCircle.png"))
        } else if(currTask.importance == "low"){
            cell.taskImportance.image = (UIImage(named: "yellowCircle.png"))
        } else{
            cell.taskImportance.image = (UIImage(named: "kotak.png"))
        }
        cell.taskImportance.clipsToBounds = true
        cell.backgroundColor = UIColor(rgb: 0xFFFFFF)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let chosenTask = taskList[indexPath.row]
        if editingStyle == .delete {
            deleteTask(task: chosenTask)
        }
    }
    
    //sort func
    func sort(sortObject: [Task]){
        let numInd = taskList.count-1
        var temp: Task
        for i in stride(from: numInd, through: 0, by: -1){
            for j in stride(from: numInd, through: numInd-i+1, by: -1){
                if(taskList[j].urgency>taskList[j-1].urgency){
                    print(j)
                    temp = taskList[j]
                    self.taskList[j] = taskList[j-1]
                    self.taskList[j-1] = temp
                }
            }
        }
    }
    
    
    // core data
    
    func getAllTasks() {
        do{
            taskList = try context.fetch(Task.fetchRequest())
            sort(sortObject: taskList)
            DispatchQueue.main.async{
                self.taskTable.reloadData()
            }
        } catch {
            print("error")
        }
    }
    
    func createTask(name: String, time: String, completed: Bool, importance: String, urgency: Int16){
        let newTask = Task(context: context)
        newTask.name = name
        newTask.time = time
        newTask.completed = completed
        newTask.importance = importance
        newTask.urgency = urgency
        
        do {
            try context.save()
        } catch {
            
        }
    }
    
    func deleteTask(task: Task){
        context.delete(task)
        do {
            try context.save()
            getAllTasks()
        } catch {
            
        }
    }
    
    func updateTask(task: Task, newCompleted: Bool){
        task.completed = newCompleted
        do {
            try context.save()
            getAllTasks()
        } catch {
            
        }
    }


}

