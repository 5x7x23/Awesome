//
//  LoginViewController.swift
//  Awesome
//
//  Created by 박익범 on 2021/04/26.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func loginButtonClicked(_ sender: Any) {
        UserApi.shared.loginWithKakaoAccount{(oauthToken, error) in
           if let error = error {
             print(error)
           }
           else {
            print("loginWithKakaoAccount() success.")
            //do something
            _ = oauthToken
           }
        }
        setUserInfo()
    }
    func setUserInfo() {
        guard let loginVC = storyboard?.instantiateViewController(identifier: "LoginCheckViewController") as? LoginCheckViewController else{return}
            UserApi.shared.me() {(user, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("me() success.")
                    //do something
                    _ = user
                    self.navigationController?.pushViewController(loginVC, animated: true)
                    loginVC.userNameText = user?.kakaoAccount?.profile?.nickname ?? ""
                                    if let url = user?.kakaoAccount?.profile?.profileImageUrl,
                                        let data = try? Data(contentsOf: url) {
                                        loginVC.profileImage?.image = UIImage(data: data)
                                    }
                }
                
                
            }
    }
}
    

