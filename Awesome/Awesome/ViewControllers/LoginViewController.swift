
import UIKit
import AuthenticationServices

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
 
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    var ifLoginFirst : Bool = false
    var ifAppleLoginFirst : Bool = false
    var userName :String = ""
    var delegate: isLogin?
    
    func isLogin(data: Bool) {
        ifLoginFirst = data
        if ifLoginFirst == true{
        }
        print("딜리게이트 실행")
    }
    
    
    func setRadius(){
        startButton.clipsToBounds = true
        startButton.layer.cornerRadius = 20
        appleLoginButton.clipsToBounds = true
        appleLoginButton.layer.cornerRadius = 20
    }
    
    func appleLogin(){
        guard let LoginVC = storyboard?.instantiateViewController(identifier: "LoginCheckViewController") as? LoginCheckViewController else {return}
        guard let alertVC = storyboard?.instantiateViewController(identifier: "AlertViewController") as? AlertViewController else {return}
        LoginVC.loginApple = true
        LoginVC.userNameText = userName
        self.navigationController?.pushViewController(LoginVC, animated: true)
//        self.present(alertVC, animated: true, completion: nil)
    }
    
//MARK: viewdidload
    override func viewDidLoad() {
        print("viewdidload")
        super.viewDidLoad()
        setRadius()
        ifSecondLogin()
    }
    
//MARK: viewWillappear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
//MARK: 자동로그인
    func updateToken(){
        let defaults = UserDefaults.standard
        let refresh = defaults.string(forKey: "refreshToken")
        print("dfafd",refresh!)
        GetAutoLoginService.shared.AutoLoginService(refresh_token: refresh!) { [self] result in
            switch result{
            case .success(let tokenData):
                print("성공")
            case .requestErr(let msg):
                print("requestErr")
            default :
                print("ERROR")
            }
        }
    }
    
    
//MARK: 자동로그인
    func ifSecondLogin(){
        let userToken = UserDefaults.standard
        let loginCode = userToken.object(forKey: "loginSecond")
        guard let mainVC = storyboard?.instantiateViewController(identifier: "LoginCheckViewController") as? LoginCheckViewController else {return}
        if (loginCode != nil) == true{
            self.updateToken()
            self.navigationController?.pushViewController(mainVC, animated: true)
        }
    }
    
    
    func ifHasToken(){
        guard let mainVC = storyboard?.instantiateViewController(identifier: "LoginCheckViewController") as? LoginCheckViewController else {return}
        guard let alrerVC = storyboard?.instantiateViewController(identifier: "AlertViewController") as? AlertViewController else {return}
        print(ifLoginFirst, "실행됨")
        
        
        if ifLoginFirst == true{
            print(ifLoginFirst, "호~잇" )
            self.present(alrerVC, animated: true, completion: nil)
            self.navigationController?.pushViewController(mainVC, animated: true)
        }
    }
    
    
    @IBAction func kakaoLoginButtonClicked(_ sender: Any) {
        guard let loginPresentVC = storyboard?.instantiateViewController(identifier: "KakaoLoginViewController") as? KakaoLoginViewController else {return}
        self.navigationController?.pushViewController(loginPresentVC, animated: true)
        loginPresentVC.delegate = self
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


extension LoginViewController : ASAuthorizationControllerDelegate{
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


extension LoginViewController : kakaoLogin {
    func kakaoLoginOn(data: Bool) {
        ifLoginFirst = data
        print(ifLoginFirst)
        if ifLoginFirst == true {
       ifHasToken()
        }
    }
    
    
}
