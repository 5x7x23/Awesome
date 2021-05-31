//
//  NotScheduleViewController.swift
//  Awesome
//
//  Created by 박익범 on 2021/05/21.
//

import UIKit

class NotScheduleViewController: UIViewController,dateData {
    func dataSend(data: String) {
        timeButton.setTitle(data, for: .normal)
    }
    
    func finishDateSend(data: String) {
        finishTimeButton.setTitle(data, for: .normal)
    }
    

    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var sellectButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var finishTimeButton: UIButton!
    
   
    
    var startTime : String = "시작시간"
    var finishTime : String = "종료시간"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .none
        setRound()

    }
    func setRound(){
        timeButton.clipsToBounds = true
        timeButton.layer.cornerRadius = 20
        sellectButton.clipsToBounds = true
        sellectButton.layer.cornerRadius = 20
        backgroundView.clipsToBounds = true
        backgroundView.layer.cornerRadius = 20
        finishTimeButton.clipsToBounds = true
        finishTimeButton.layer.cornerRadius = 20
        mainView.backgroundColor = .none
    }
    @IBAction func timeButtonClicked(_ sender: Any) {
        guard let startVC = storyboard?.instantiateViewController(identifier: "StartDateViewController") as? StartDateViewController else {return}
        self.present(startVC, animated: true, completion: nil)
        startVC.delegate = self
    }
    @IBAction func finishTimeButtonClicked(_ sender: Any) {
        guard let finishVC = storyboard?.instantiateViewController(identifier: "FinishDataViewController") as? FinishDataViewController else {return}
        self.present(finishVC, animated: true, completion: nil)
        finishVC.finishDelegate = self
    }
    @IBAction func selectButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
