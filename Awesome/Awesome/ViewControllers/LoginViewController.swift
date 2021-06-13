import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices
import WebKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    var webView: WKWebView!
    
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
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 20
        appleLoginButton.clipsToBounds = true
        appleLoginButton.layer.cornerRadius = 20
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
    
    @IBAction func appleLoginButtonClicked(_ sender: Any) {
        
    }
    





}

    

