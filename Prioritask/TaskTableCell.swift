//
//  TaskTableCell.swift
//  Prioritask
//
//  Created by Vincentius Ian Widi Nugroho on 27/04/22.
//

import UIKit

class TaskTableCell: UITableViewCell {
    var completed: Bool = false

    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var taskButton: UIButton!
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskTime: UILabel!
    @IBOutlet weak var taskImportance: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func change(){
//        if (completed) {
//            taskbutton.setImage(<#T##UIImage?#>, for: <#T##UIControl.State#>)
//        }
//    }

    @IBAction func taskButtonPressed(_ sender: Any) {
        completed = !completed
        setButton()
    }
    
    func setButton(){
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: taskName.text!)
        if(completed){
            taskButton.setImage(UIImage(named: "kotakChecked.png"), for: .normal)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        } else {
            taskButton.setImage(UIImage(named: "kotak.png"), for: .normal)
            attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0,attributeString.length))
        }
        taskName.attributedText = attributeString
    }
}
