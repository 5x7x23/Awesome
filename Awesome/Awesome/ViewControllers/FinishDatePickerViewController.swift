//
//  FinishDatePickerViewController.swift
//  Awesome
//
//  Created by 박익범 on 2021/05/05.
//

import UIKit




class FinishDatePickerViewController: UIViewController {
    @IBOutlet weak var finishDatepicker: UIDatePicker!
    var chooseDate : String = ""
    var finishDelegate : dateData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func finishDatePicker(_ sender: Any) {
        pickerChanged()
    }
    func pickerChanged(){
           let dateformatter = DateFormatter()
           dateformatter.dateStyle = .none
           dateformatter.timeStyle = .short
        dateformatter.locale = Locale(identifier: "en_GB")
        chooseDate = dateformatter.string(from: finishDatepicker.date)
           
    }
    @IBAction func okButtonClicked(_ sender: Any) {
        finishDelegate?.finishDateSend(data: chooseDate)
        self.dismiss(animated: true, completion: nil)
        print(chooseDate)
        
    }
    
}
