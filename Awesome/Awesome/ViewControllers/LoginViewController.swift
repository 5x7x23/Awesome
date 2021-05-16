import UIKit
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let loginSecond = storyboard?.instantiateViewController(identifier: "LoginCheckViewController") as? LoginCheckViewController else {return}
        if AuthApi.hasToken() == true{ //로그인 체크함
            self.navigationController?.pushViewController(loginSecond, animated: true)
        }
        super.viewWillAppear(true)
    }
    @IBAction func loginButtonClicked(_ sender: Any) {
        UserApi.shared.loginWithKakaoAccount{(oauthToken, error) in
           if let error = error {
             print(error)
           }
           else {
            print("loginWithKakaoAccount() success.")
            self.presentToAlert()
            //do something
            _ = oauthToken
           }
        }
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
    }

    

