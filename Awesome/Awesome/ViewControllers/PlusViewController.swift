//
//  PlusViewController.swift
//  Awesome
//
//  Created by 박익범 on 2021/05/05.
//

import UIKit

class PlusViewController: UIViewController,dateData {
    func dataSend(data: String) {
        timeLabel.text = data
    }
    func finishDateSend(data: String) {
        finishTimeLabel.text = data
    }
    

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var finishTimeLabel: UILabel!
    var nameText : String = "이름"
    var startTime : String = "시작시간"
    var finishTime : String = "종료시간"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        nameLabel.text = nameText
        
    }
    
    @IBAction func nameButtonClicked(_ sender: Any) {
        let nameAlert = UIAlertController(title: "이름을 입력하세요", message: "", preferredStyle: UIAlertController.Style.alert)
        nameAlert.addTextField()
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            self.nameText = nameAlert.textFields?[0].text ?? ""
            self.nameLabel.text = self.nameText
           
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .default)
        {(action) in}
        nameAlert.addAction(okAction)
        nameAlert.addAction(cancelAction)
        present(nameAlert, animated: true, completion: nil)
    }
    
    @IBAction func timeButtonClicked(_ sender: Any) {
        guard let dateVC = storyboard?.instantiateViewController(identifier: "DatepickerViewController") as? DatepickerViewController else {return}
        dateVC.delegate = self
        self.present(dateVC, animated: true, completion: nil)
        print(startTime)
    }
   
    
    @IBAction func finishTimeButtonClicked(_ sender: Any) {
        guard let finishDateVC = storyboard?.instantiateViewController(identifier: "FinishDatePickerViewController") as? FinishDatePickerViewController else {return}
        finishDateVC.finishDelegate = self
        self.present(finishDateVC, animated: true, completion: nil)
    }
    @IBAction func okButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
