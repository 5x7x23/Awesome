//
//  SettingViewController.swift
//  Awesome
//
//  Created by 박익범 on 2021/04/27.
//

import UIKit
import KakaoSDKUser

class SettingViewController: UIViewController {
    @IBOutlet weak var linkShare: UIView!
    @IBOutlet weak var linkshareButton: UIButton!
    @IBOutlet weak var notificationView: UIView!
    
    
    @IBOutlet weak var withdrawView: UIView!
    @IBOutlet weak var logoutView: UIView!
    
    @IBOutlet weak var shareMyAwesome: UILabel!
    
    var inviteLink: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewRadius()

    }
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func viewRadius(){
        linkShare.clipsToBounds = true
        linkShare.layer.cornerRadius = 15
        linkshareButton.clipsToBounds = true
        linkshareButton.layer.cornerRadius = 15
        notificationView.clipsToBounds = true
        notificationView.layer.cornerRadius = 15
        logoutView.clipsToBounds = true
        logoutView.layer.cornerRadius = 15
        withdrawView.clipsToBounds = true
        withdrawView.layer.cornerRadius = 15
        
        
    }
    
    func uppdateProfile(){
        GetInviteService.inviteData.getRecommendInfo{ (response) in
            switch(response)
            {
            case .success(let loginData):
                if let response = loginData as? InviteDataModel{
                    DispatchQueue.global().async {
                        self.inviteLink.append("📩 \(UserDefaults.standard.string(forKey: "name")!)님께서 '어떰'의 초대장을 보내셨습니다!\n\n '어떰'은 개인링크로 일정📅을 공유해 간편하게 약속을 잡을 수 있는 서비스입니다.\n\n ✉ 초대링크: \(response.link) \n\n😝잉여 시간에 약속신청 받고 놀러가자😝")
                        print(self.inviteLink, response.link)
                    }
                }
                print(loginData)
            case .requestErr(let message):
                print("requestERR")
            case .pathErr :
                print("pathERR")
            case .serverErr:
                print("serverERR")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    
    @IBAction func inviteButtonClicked(_ sender: Any) {
        uppdateProfile()
            print(inviteLink)
        let activityVC = UIActivityViewController(activityItems: inviteLink, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
//        activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
        self.present(activityVC, animated: true, completion: nil)
   
    }
    @IBAction func linkshareButtonClicked(_ sender: Any) {
        var objectsToShare = [String]()
        
        if let text = shareMyAwesome.text{
                   objectsToShare.append(text)
                   print("[INFO] textField's Text : ", text)
               }
               
               let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
               activityVC.popoverPresentationController?.sourceView = self.view
               
               // 공유하기 기능 중 제외할 기능이 있을 때 사용
       //        activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
               self.present(activityVC, animated: true, completion: nil)
        
        
    }
    
    @IBAction func logOutButtonClicked(_ sender: Any) {
        guard let logoutVC = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else {return}
        let alert = UIAlertController(title: "로그아웃", message: "로그아웃하여 초기화면으로 이동합니다.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            let defaults = UserDefaults.standard
            let refresh = defaults.string(forKey: "refreshToken")
            print("dfafd",refresh!)
            GetAutoLoginService.shared.AutoLoginService(refresh_token: refresh!) { [self] result in
                switch result{
                case .success(let tokenData):
                    print("로그아웃 성공")
                    defaults.removeObject(forKey: "refreshToken")
                    defaults.removeObject(forKey: "accessToken")
                    defaults.removeObject(forKey: "name")
                    defaults.removeObject(forKey: "profile")
                    defaults.removeObject(forKey: "loginSecond")
                    self.navigationController?.pushViewController(logoutVC, animated: true)
                case .requestErr(let msg):
                    print("requestErr")
                default :
                    print("ERROR")
                }
            }
//            UserApi.shared.logout {(error) in
//            if let error = error {
//                print(error)
//            }
//            else {
//                print("logout() success.")
//            }
//            guard let logoutVC = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else {return}
//            self.navigationController?.pushViewController(logoutVC, animated: true)
//        }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .default)
        {(action) in}
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
}
