//
//  PromiseAlertViewController.swift
//  Awesome
//
//  Created by 박익범 on 2021/05/05.
//

import UIKit

protocol data {
    func deleteData()
}

class PromiseAlertViewController: UIViewController {
    @IBOutlet weak var nameConstraint: NSLayoutConstraint!
    @IBOutlet weak var subjectConstraint: NSLayoutConstraint!
    @IBOutlet weak var subjectUpConstarint: NSLayoutConstraint!
    @IBOutlet weak var subjectDownConstarint: NSLayoutConstraint!
    @IBOutlet weak var nameRigthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var promiseObject: UILabel!
    var deleteDelegate : data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        self.promiseObject.lineBreakStrategy = .hangulWordPriority
        self.promiseObject.numberOfLines = 5
        let width = UIScreen.main.bounds.width
        
//        375  아이폰8
//        414 아이폰 11
//        375 아이폰 11프로
//        414 아이폰 프맥
//        390 아이폰 12,12프로
//        428 아이폰 12프맥
//        360 아이폰 12미니
        if width == 375 { // 아이폰8, 아이폰 11프로
            subjectConstraint.constant = 60
            nameConstraint.constant = 60
            subjectUpConstarint.constant = 20
            subjectDownConstarint.constant = 20
        }
        if width == 414{ //아이폰 11
            subjectConstraint.constant = 70
            nameConstraint.constant = 70
            nameRigthConstraint.constant = 25
            subjectUpConstarint.constant = 35
            subjectDownConstarint.constant = 35
        }
        if width == 390{
            subjectConstraint.constant = 70
            nameConstraint.constant = 70
            nameRigthConstraint.constant = 25
            subjectUpConstarint.constant = 25
            subjectDownConstarint.constant = 25
        }
        if width == 428{
            subjectConstraint.constant = 70
            nameConstraint.constant = 70
            nameRigthConstraint.constant = 30
            subjectUpConstarint.constant = 45
            subjectDownConstarint.constant = 45
        }
        if width == 360{
            subjectConstraint.constant = 65
            nameConstraint.constant = 65
            nameRigthConstraint.constant = 30
            subjectUpConstarint.constant = 20
            subjectDownConstarint.constant = 20
        }
    }
    
    
    func setData(name : String , information : String, person : String){
        nameLabel.text = person
        timeLabel.text = name
        promiseObject.text = information
    }
    @IBAction func acceptButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        deleteDelegate?.deleteData()
    }
    @IBAction func denineButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        deleteDelegate?.deleteData()
    }
}

