//
//  CommentAlertViewController.swift
//  Awesome
//
//  Created by 박익범 on 2021/05/05.
//

import UIKit

class CommentAlertViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        self.informationLabel.numberOfLines = 5
        // Do any additional setup after loading the view.
    }
    @IBAction func okButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
