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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var promiseObject: UILabel!
    var deleteDelegate : data?
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var subjectView: UIView!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var denineButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var headerLabelConstraint: NSLayoutConstraint!
    
    let width = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        self.promiseObject.lineBreakStrategy = .hangulWordPriority
        self.promiseObject.numberOfLines = 5
        setRadius()
        setLabelFont()

    }
    func setLabelFont(){
        headerLabelConstraint.constant = headerLabelConstraint.constant * (width/428)
    }
//    func resolutionFontSize(size : CGFloat) -> CGFloat{
//        let sizeFormatter = size/320
//        let result = width * sizeFormatter
//        return result
//    }
    func setData(name : String , information : String, person : String){
        nameLabel.text = person
        timeLabel.text = name
        promiseObject.text = information
    }
    
    func setRadius(){
        backgroundView.clipsToBounds = true
        backgroundView.layer.cornerRadius = 12
        nameView.clipsToBounds = true
        nameView.layer.cornerRadius = 12
        timeView.clipsToBounds = true
        timeView.layer.cornerRadius = 12
        subjectView.clipsToBounds = true
        subjectView.layer.cornerRadius = 12
        acceptButton.clipsToBounds = true
        acceptButton.layer.cornerRadius = 20
        denineButton.clipsToBounds = true
        denineButton.layer.cornerRadius = 20
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


