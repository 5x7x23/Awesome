//
//  StartDateViewController.swift
//  Awesome
//
//  Created by 박익범 on 2021/05/31.
//

import UIKit

class StartDateViewController: UIViewController {

    var chooseDate : String = ""
    var delegate : dateData?
    @IBOutlet weak var pickerView: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    @IBAction func dataPickerSelected(_ sender: Any) {
        changed()
    }
    
    func changed(){
           let dateformatter = DateFormatter()
        dateformatter.dateStyle = .short
           dateformatter.timeStyle = .none
        chooseDate = dateformatter.string(from: pickerView.date)
    }

    @IBAction func okButtonClicked(_ sender: Any) {
        delegate?.dataSend(data: chooseDate)
        self.dismiss(animated: true, completion: nil)
    }
}
