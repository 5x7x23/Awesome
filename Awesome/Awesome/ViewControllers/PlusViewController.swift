//
//  PlusViewController.swift
//  Awesome
//
//  Created by 박익범 on 2021/05/05.
//

import UIKit

class PlusViewController: UIViewController,dateData {
    func dataSend(data: String) {
        startTimeButton.setTitle(data, for: .normal)
    }
    func finishDateSend(data: String) {
        finishTimeButton.setTitle(data, for: .normal)
    }
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var startTimeButton: UIButton!
    @IBOutlet weak var finishTimeButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var okButton: UIButton!
    
    var nameText : String = "이름"
    var startTime : String = "시작시간"
    var finishTime : String = "종료시간"

    override func viewDidLoad() {
        super.viewDidLoad()
        setRound()
        self.view.backgroundColor = .clear
    }
    
    func setRound(){
        nameButton.clipsToBounds = true
        nameButton.layer.cornerRadius = 20
        startTimeButton.clipsToBounds = true
        startTimeButton.layer.cornerRadius = 20
        finishTimeButton.clipsToBounds = true
        finishTimeButton.layer.cornerRadius = 20
        backgroundView.clipsToBounds = true
        backgroundView.layer.cornerRadius = 20
        okButton.clipsToBounds = true
        okButton.layer.cornerRadius = 20
    }
    
    @IBAction func nameButtonClicked(_ sender: Any) {
        let nameAlert = UIAlertController(title: "이름을 입력하세요", message: "", preferredStyle: UIAlertController.Style.alert)
        nameAlert.addTextField()
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            self.nameText = nameAlert.textFields?[0].text ?? ""
            self.nameButton.setTitle(self.nameText, for: .normal)
           
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
