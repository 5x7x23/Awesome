//
//  LoginCheckViewController.swift
//  Awesome
//
//  Created by 박익범 on 2021/04/27.
//

import UIKit
import KakaoSDKUser

class LoginCheckViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var userName: UILabel!
    var userNameText : String = ""
    var urlProfile : String = ""
    

    
    
    override func viewDidLoad() {
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.clear.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        super.viewDidLoad()
        uppdateProfile()
    }
    override func viewDidAppear(_ animated: Bool) {
        uppdateProfile()
        }
    override func viewWillAppear(_ animated: Bool) {
        uppdateProfile()
    }
    
    @IBAction func settingButtonClicked(_ sender: Any) {
        guard let settingVC = storyboard?.instantiateViewController(identifier: "SettingViewController") as? SettingViewController else {return}
        self.navigationController?.pushViewController(settingVC, animated: true)
        let notificationAlert = UIAlertController(title: "Your Title", message: "Your Message", preferredStyle: UIAlertController.Style.actionSheet)
        
    }
    
    func uppdateProfile(){
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                self.userName.text = user?.kakaoAccount?.profile?.nickname ?? ""
                print("me() success.")
                //do something
                _ = user
                if let url = user?.kakaoAccount?.profile?.profileImageUrl,
                    let data = try? Data(contentsOf: url) {
                    self.profileImage?.image = UIImage(data: data)
            }
            }
    }
    }
    
    
    
}
