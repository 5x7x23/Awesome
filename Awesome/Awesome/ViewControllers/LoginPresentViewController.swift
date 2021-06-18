//
//  LoginPresentViewController.swift
//  Awesome
//
//  Created by 박익범 on 2021/06/18.
//

import UIKit
import KakaoSDKUser
import KakaoSDKAuth


class LoginPresentViewController: UIViewController{
    
    var delegate : isLogin?
   
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var kakaoLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewWillAppear(true)
        setRadius()

    }
    
    func setRadius(){
        kakaoLoginButton.clipsToBounds = true
        kakaoLoginButton.layer.cornerRadius = 10
        appleLoginButton.clipsToBounds = true
        appleLoginButton.layer.cornerRadius = 10
        backgroundView.clipsToBounds = true
        backgroundView.layer.cornerRadius = 20
        view.backgroundColor = .none
        
    }
    @IBAction func kakaoLoginButtonClicked(_ sender: Any) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    //do something
                    _ = oauthToken
//                    self.dismiss(animated: true, completion: nil)
                    self.presentToAlert()
                }
            }
        }
        else{
            kakaoLogin()
        }
    }
    
    
    @IBAction func AppleLoginButtonClicked(_ sender: Any) {
    }
    
    
    func presentToAlert(){
        guard let loginVC = storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else {return}
        UserApi.shared.me() {(user, error) in
            
            if let error = error {
                print(error)
                        }
            else {
                print("me() success.")
                //do something
                _ = user
                }
        }
                if AuthApi.hasToken() == true{
                    self.dismiss(animated: true, completion: nil)
                    delegate?.isLogin(data: true)
                    print("여기는 잘 됨")
                    
                }
    }
    
    func kakaoLogin(){
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    //do something
                    _ = oauthToken
                    self.presentToAlert()
                }
            }
    }
    
    

}

