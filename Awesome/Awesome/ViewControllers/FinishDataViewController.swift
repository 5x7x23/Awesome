//
//  FinishDataViewController.swift
//  Awesome
//
//  Created by 박익범 on 2021/05/31.
//

import UIKit

class FinishDataViewController: UIViewController {

    var chooseDate : String = ""
    var finishDelegate : dateData?
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func datePickerChoosed(_ sender: Any) {
        changed()
    }
    
    func changed(){
           let dateformatter = DateFormatter()
           dateformatter.dateStyle = .short
           dateformatter.timeStyle = .none
        chooseDate = dateformatter.string(from: datePicker.date)
    }

    @IBAction func okButtonClicked(_ sender: Any) {
        finishDelegate?.finishDateSend(data: chooseDate)
        self.dismiss(animated: true, completion: nil)
    }
}
