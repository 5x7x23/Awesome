//
//  LoginPresentViewController.swift
//  Awesome
//
//  Created by 박익범 on 2021/06/18.
//

import UIKit
import KakaoSDKUser
import KakaoSDKAuth
import AuthenticationServices


class LoginPresentViewController: UIViewController{
   
    
    var delegate : isLogin?
   
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var kakaoLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRadius()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("프레젠트 뷰 생성")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("프레젠트 뷰 사라짐")
  
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
        guard let loginPresentVC = storyboard?.instantiateViewController(identifier: "KakaoLoginViewController") as? KakaoLoginViewController else {return}
        LoginViewController.topViewController()
        self.present(loginPresentVC, animated: true, completion: nil)
        
        
//        guard let pvc = self.presentingViewController else { return }
//        self.dismiss(animated: true) {
//          pvc.present(KakaoLoginViewController(), animated: true, completion: nil)
//        }
        
//        if (UserApi.isKakaoTalkLoginAvailable()) {
//            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
//                if let error = error {
//                    print(error)
//                }
//                else {
//                    print("loginWithKakaoTalk() success.")
//                    //do something
//                    _ = oauthToken
//                    self.dismiss(animated: true, completion: nil)
//                    self.presentToAlert()
//                }
//            }
//        }
//        else{
//            kakaoLogin()
//        }
    }
    
    
    
    @IBAction func AppleLoginButtonClicked(_ sender: Any) {
        let request = ASAuthorizationAppleIDProvider().createRequest()
               request.requestedScopes = [.fullName, .email]
        
               let controller = ASAuthorizationController(authorizationRequests: [request])
               controller.delegate = self as? ASAuthorizationControllerDelegate
               controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
               controller.performRequests()
    }
    
    
    func presentToAlert(){
//        UserApi.shared.me() {(user, error) in
//
//            if let error = error {
//                print(error)
//                        }
//            else {
//                print("me() success.")
//                //do something
//                _ = user
//                }
//        }
//                if AuthApi.hasToken() == true{
//                    self.dismiss(animated: true, completion: nil)
//                    delegate?.isLogin(data: true)
//                }
    }
    
//    func kakaoLogin(){
//        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
//                if let error = error {
//                    print(error)
//                }
//                else {
//                    print("loginWithKakaoAccount() success.")
//                    //do something
//                    _ = oauthToken
//                    self.presentToAlert()
//                }
//            }
//}

}

extension LoginPresentViewController : ASAuthorizationControllerDelegate{
    // 성공 후 동작
        func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
            
            
            if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
                guard let LoginCompletVC = storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else {return}
                navigationController?.pushViewController(LoginCompletVC, animated: true)
        
                let idToken = credential.identityToken!
                let tokeStr = String(data: idToken, encoding: .utf8)
                print("호호",tokeStr)

                guard let code = credential.authorizationCode else { return }
                let codeStr = String(data: code, encoding: .utf8)
                print("호호", codeStr)

                let user = credential.fullName
                print(user?.givenName)
                self.dismiss(animated: true, completion: nil)
//              delegate?.isAppleLogin(data: true, name: user?.givenName ?? "")

            }
        }

        // 실패 후 동작
        func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            print("error")
        }
}
