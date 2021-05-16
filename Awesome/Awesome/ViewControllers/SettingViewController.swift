//
//  SettingViewController.swift
//  Awesome
//
//  Created by 박익범 on 2021/04/27.
//

import UIKit
import KakaoSDKUser

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
