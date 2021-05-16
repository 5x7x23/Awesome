//
//  DatepickerViewController.swift
//  Awesome
//
//  Created by 박익범 on 2021/05/05.
//

import UIKit

protocol dateData {
    func dataSend(data : String)
    func finishDateSend(data : String)
}


class DatepickerViewController: UIViewController {

    @IBOutlet weak var pickerView: UIDatePicker!
    var chooseDate : String = ""
    var delegate : dateData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func datepickerSelected(_ sender: Any) {
        changed()
    }
    func changed(){
           let dateformatter = DateFormatter()
           dateformatter.dateStyle = .none
           dateformatter.timeStyle = .short
        chooseDate = dateformatter.string(from: pickerView.date)
           
    }
    @IBAction func okButtonClicked(_ sender: Any) {
        guard let plusVC = storyboard?.instantiateViewController(identifier: "PlusViewController") as? PlusViewController else {return}
        delegate?.dataSend(data: chooseDate)
        self.dismiss(animated: true, completion: nil)
        print(chooseDate)
    }
    
    
}
