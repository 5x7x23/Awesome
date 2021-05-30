//
//  NotScheduleViewController.swift
//  Awesome
//
//  Created by 박익범 on 2021/05/21.
//

import UIKit

class NotScheduleViewController: UIViewController {

    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var sellectButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet var mainView: UIView!
    
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
        mainView.backgroundColor = .none
    }
    @IBAction func timeButtonClicked(_ sender: Any) {
        
    }
    
    @IBAction func selectButtonClicked(_ sender: Any) {
        
    }
}
