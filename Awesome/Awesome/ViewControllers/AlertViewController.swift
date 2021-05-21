//
//  AlertViewController.swift
//  Awesome
//
//  Created by 박익범 on 2021/04/29.
//

import UIKit
import KakaoSDKAuth

class AlertViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        view.isOpaque = true
        self.view.sendSubviewToBack(backgroundView)
    }
    @IBAction func alertButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
            print("알림 활성화")
    }
    @IBAction func laterButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        print("다음에")
    }
    
}
