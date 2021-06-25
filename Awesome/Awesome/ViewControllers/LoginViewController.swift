
import UIKit
import KakaoSDKAuth
import KakaoSDKUser

protocol isLogin {
    func isLogin(data : Bool)
    func isAppleLogin(data : Bool, name : String)
}

class LoginViewController: UIViewController, isLogin{
    func isAppleLogin(data: Bool, name: String) {
        ifAppleLoginFirst = data
        userName = name
        appleLogin()
    }
    func isLogin(data: Bool) {
        ifLoginFirst = data
        LoginViewController.topViewController()
        ifHasToken()
        print("딜리게이트 실행됨 ㅋ 끼익", ifLoginFirst)
    }
    @IBOutlet weak var startButton: UIButton!
    var ifLoginFirst : Bool = false
    var ifAppleLoginFirst : Bool = false
    var userName :String = ""
    
    func setRadius(){
        startButton.clipsToBounds = true
        startButton.layer.cornerRadius = 20
    }
    
    func appleLogin(){
        guard let LoginVC = storyboard?.instantiateViewController(identifier: "LoginCheckViewController") as? LoginCheckViewController else {return}
        guard let alertVC = storyboard?.instantiateViewController(identifier: "AlertViewController") as? AlertViewController else {return}
        LoginVC.loginApple = true
        LoginVC.userNameText = userName
        self.navigationController?.pushViewController(LoginVC, animated: true)
        self.present(alertVC, animated: true, completion: nil)
    }
//MARK: viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidAppear(true)
        super.viewWillAppear(true)
        setRadius()
        ifHasToken()
        
    }
//MARK: viewWillappear
    override func viewWillAppear(_ animated: Bool) {
        ifHasToken()
    }
    override func viewDidAppear(_ animated: Bool) {
        ifHasToken()
    }
    func ifHasToken(){
        guard let mainVC = storyboard?.instantiateViewController(identifier: "LoginCheckViewController") as? LoginCheckViewController else {return}
        guard let alrerVC = storyboard?.instantiateViewController(identifier: "AlertViewController") as? AlertViewController else {return}
        guard let loginVC = storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else {return}
        print(ifLoginFirst , "1231241")
        print("디스미스 다 됨")
        
        
        LoginViewController.topViewController()
        if ifLoginFirst == true{
            LoginViewController.topViewController()
            self.navigationController?.pushViewController(mainVC, animated: true)
            self.present(alrerVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func startButtonClicked(_ sender: Any) {
        guard let loginVC = storyboard?.instantiateViewController(identifier: "LoginPresentViewController") as? LoginPresentViewController else {return}
        guard let kakaoLoginVC = storyboard?.instantiateViewController(identifier: "KakaoLoginViewController") as? KakaoLoginViewController else {return}
        self.present(loginVC, animated: true, completion: nil)
        loginVC.delegate = self
        ifHasToken()
        print(ifLoginFirst)
    }
    
    
    class func topViewController() -> UIViewController? {
        if let keyWindow = UIApplication.shared.keyWindow {
            if var viewController = keyWindow.rootViewController {
                while viewController.presentedViewController != nil {
                    viewController = viewController.presentedViewController!
                }
                print("topViewController -> \(String(describing: viewController))")
                return viewController
            }
        }
        return nil
    }


}
extension LoginViewController : kakaoLogin {
    func kakaoLoginOn(data: Bool) {
        ifLoginFirst = data
        print(ifLoginFirst)
        if ifLoginFirst == true {
       ifHasToken()
        }
    }
    
    
}
