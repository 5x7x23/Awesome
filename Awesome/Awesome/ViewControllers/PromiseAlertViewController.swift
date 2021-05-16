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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        self.promiseObject.lineBreakStrategy = .hangulWordPriority
        self.promiseObject.numberOfLines = 5
        // Do any additional setup after loading the view.
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
