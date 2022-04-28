//
//  AddViewController.swift
//  Prioritask
//
//  Created by Vincentius Ian Widi Nugroho on 27/04/22.
//

import UIKit
import Foundation

class AddViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    let daftarPil = ["low","medium","high"]
    
    var timeAppear: Bool = false
    var taskName: String = "nodata"
    var waktu: String = "nodata"
    var waktuTask: String = ""
    var importance: String = "nodata"
    var urgency: Int = 0
    let timePicker = UIDatePicker()
    let bottomBorder = CALayer()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var dropButton: UIButton!
    @IBOutlet weak var tabelPilihan: UITableView!
    @IBOutlet weak var tabelPilihan2: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var nameLabel: UIView!
    @IBOutlet weak var urgencyView: UIView!
    @IBOutlet weak var importanceView: UIView!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var urgencyLabel: UILabel!
    @IBOutlet weak var importanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let time = Date()
        let formatter = DateFormatter()
        
        addBottomBorders(view: nameLabel)
        addBottomBorders(view: urgencyView)
        addBottomBorders(view: importanceView)
        self.tabelPilihan.isHidden = true
        self.tabelPilihan2.isHidden = true
        tabelPilihan.layer.borderWidth = 0.5
        tabelPilihan2.layer.borderWidth = 0.5
        
        formatter.dateFormat = "HH:mm"
        waktu = formatter.string(from: time)
        timePicker.datePickerMode = .countDownTimer
        timePicker.frame = CGRect(x:0.0, y: (self.view.frame.height/2 + 60), width: self.view.frame.width, height: 150.0)
        timePicker.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
    }
    
    func addBottomBorders(view: UIView) {
       let thickness: CGFloat = 1.0
       let bottomBorder = CALayer()
       bottomBorder.frame = CGRect(x:0, y: view.frame.size.height - thickness, width: view.frame.size.width, height:thickness)
       bottomBorder.backgroundColor = UIColor.black.cgColor
       view.layer.addSublayer(bottomBorder)
    }
    
    @objc func timePickerValueChanged(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        waktu = formatter.string(from: sender.date)
    }
    
    @IBAction func chooseTime(){
        if (!timeAppear){
            self.view.addSubview(timePicker)
        } else {
            timePicker.removeFromSuperview()
            setTimeText()
            timeLabel.text = waktuTask
        }
        timeAppear = !timeAppear
    }
    
    @IBAction func pickPilihan(_ sender: Any) {
        self.tabelPilihan.isHidden = !self.tabelPilihan.isHidden
    }
    @IBAction func pickPilihan2(_ sender: Any) {
        self.tabelPilihan2.isHidden = !self.tabelPilihan2.isHidden
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        taskName = nameField.text!
        setTimeText()
        createTask(name: taskName, time: waktuTask, completed: false, importance: importance, urgency: Int16(urgency))
    }
    
    // time
    func setTimeText(){
        var fullTime: String = waktu
        let fullTimeArr = fullTime.components(separatedBy: ":")

        var hour: String = fullTimeArr[0]
        var minute: String = fullTimeArr[1]
        waktuTask = "\(hour) hour \(minute) minutes"
    }
    
    // text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            nameField.resignFirstResponder()
            return (true)
        }
    
    // create task
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
    
    // function dropdown
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daftarPil.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = daftarPil[indexPath.row]
        cell.backgroundColor = UIColor(rgb: 0xFFFFFF)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if(tableView == self.tabelPilihan){
            urgencyLabel.text = (cell?.textLabel?.text)!
            urgency = setUrgency(urText: (cell?.textLabel?.text)!)
            self.tabelPilihan.isHidden = true
        } else if (tableView == self.tabelPilihan2){
            importance = (cell?.textLabel?.text)!
            importanceLabel.text = importance
            self.tabelPilihan2.isHidden = true
        }
    }
    
    func setUrgency(urText: String) -> Int {
        if(urText == "high"){
            return 3
        } else if (urText == "medium"){
            return 2
        } else if (urText == "low"){
            return 1
        } else {
            return 0
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
