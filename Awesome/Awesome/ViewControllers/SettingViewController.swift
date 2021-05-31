//
//  SettingViewController.swift
//  Awesome
//
//  Created by 박익범 on 2021/04/27.
//

import UIKit
import KakaoSDKUser

class SettingViewController: UIViewController {
    @IBOutlet weak var linkShare: UIView!
    @IBOutlet weak var linkshareButton: UIButton!
    @IBOutlet weak var notificationView: UIView!
    
    @IBOutlet weak var callendarView: UIView!
    
    @IBOutlet weak var withdrawView: UIView!
    @IBOutlet weak var logoutView: UIView!
    
    @IBOutlet weak var shareMyAwesome: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewRadius()

    }
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func viewRadius(){
        linkShare.clipsToBounds = true
        linkShare.layer.cornerRadius = 15
        linkshareButton.clipsToBounds = true
        linkshareButton.layer.cornerRadius = 15
        notificationView.clipsToBounds = true
        notificationView.layer.cornerRadius = 15
        callendarView.clipsToBounds = true
        callendarView.layer.cornerRadius = 15
        logoutView.clipsToBounds = true
        logoutView.layer.cornerRadius = 15
        withdrawView.clipsToBounds = true
        withdrawView.layer.cornerRadius = 15
        
        
    }
    @IBAction func linkshareButtonClicked(_ sender: Any) {
        var objectsToShare = [String]()
        if let text = shareMyAwesome.text{
                   objectsToShare.append(text)
                   print("[INFO] textField's Text : ", text)
               }
               
               let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
               activityVC.popoverPresentationController?.sourceView = self.view
               
               // 공유하기 기능 중 제외할 기능이 있을 때 사용
       //        activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
               self.present(activityVC, animated: true, completion: nil)
        
        
    }
    
    @IBAction func logOutButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "로그아웃", message: "로그아웃하여 초기화면으로 이동합니다.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("logout() success.")
            }
            guard let logoutVC = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else {return}
            self.navigationController?.pushViewController(logoutVC, animated: true)
        }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .default)
        {(action) in}
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
}
