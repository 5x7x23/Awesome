
import UIKit
import KakaoSDKAuth
import KakaoSDKUser

protocol isLogin {
    func isLogin(data : Bool)
}

class LoginViewController: UIViewController, isLogin{
    
    func isLogin(data: Bool) {
        ifLoginFirst = data
        ifHasToken()
        print("딜리게이트 실행됨 ㅋ", ifLoginFirst)
    }
    

    @IBOutlet weak var startButton: UIButton!
    var ifLoginFirst : Bool = false
    
    func setRadius(){
        startButton.clipsToBounds = true
        startButton.layer.cornerRadius = 20
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setRadius()
        ifHasToken()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        ifHasToken()
    }
    
    func ifHasToken(){
        guard let mainVC = storyboard?.instantiateViewController(identifier: "LoginCheckViewController") as? LoginCheckViewController else {return}
        guard let alrerVC = storyboard?.instantiateViewController(identifier: "AlertViewController") as? AlertViewController else {return}
        
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
                    self.navigationController?.pushViewController(mainVC, animated: true)
                    print("호잇", ifLoginFirst)
                    if ifLoginFirst == true{
                    self.present(alrerVC, animated: true, completion: nil)
                    }
                    }
    }
    
    @IBAction func startButtonClicked(_ sender: Any) {
        guard let loginVC = storyboard?.instantiateViewController(identifier: "LoginPresentViewController") as? LoginPresentViewController else {return}
        
        self.present(loginVC, animated: true, completion: nil)
        loginVC.delegate = self
    }
    
}
