import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices
import WebKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var appleLoginView: UIView!
    var webView: WKWebView!
    @IBOutlet weak var appleLoginButton: UIButton!

    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        setRound()

        webView = WKWebView(frame: self.view.frame)
        
        guard let loginSecond = storyboard?.instantiateViewController(identifier: "LoginCheckViewController") as? LoginCheckViewController else {return}
        if AuthApi.hasToken() == true{ //로그인 체크함
            self.navigationController?.pushViewController(loginSecond, animated: true)
        }
        super.viewWillAppear(true)
    }
    @IBAction func loginButtonClicked(_ sender: Any) {
//        UserApi.shared.loginWithKakaoAccount{(oauthToken, error) in
//           if let error = error {
//             print(error)
//           }
//           else {
//            print("loginWithKakaoAccount() success.")
//            self.presentToAlert()
//            //do something
//            _ = oauthToken
//           }
//        }
        guard let kakaoVC = storyboard?.instantiateViewController(identifier: "KakaoLoginViewController") as? KakaoLoginViewController else {return}
        self.present(kakaoVC, animated: true, completion: nil)

    }
    func setRound(){
        appleLoginButton.clipsToBounds = true
        appleLoginButton.layer.cornerRadius = 20
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 20
        
    }
    
    
    func presentToAlert() {
        guard let loginVC = storyboard?.instantiateViewController(identifier: "LoginCheckViewController") as? LoginCheckViewController else{return}
        guard let allertVC = storyboard?.instantiateViewController(identifier: "AlertViewController") as? AlertViewController else{return}
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
            self.navigationController?.pushViewController(loginVC, animated: true)
            self.present(allertVC, animated: true, completion: nil)
        }
            }
   
    @IBAction func AppleLoginButtonClicked(_ sender: Any) {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self as? ASAuthorizationControllerDelegate
        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
    }
    
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    // 성공 후 동작
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let LoginCompletVC = storyboard?.instantiateViewController(identifier: "LoginCheckViewController") as? LoginCheckViewController else {return}
            navigationController?.pushViewController(LoginCompletVC, animated: true)

            let idToken = credential.identityToken!
            let tokeStr = String(data: idToken, encoding: .utf8)
            print("호호",tokeStr)

            guard let code = credential.authorizationCode else { return }
            let codeStr = String(data: code, encoding: .utf8)
            print("호호", codeStr)

            let user = credential.user
            print("중요",String(user))

        }
    }

    // 실패 후 동작
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("error")
    }
}
