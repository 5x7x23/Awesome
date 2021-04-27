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
        super.viewDidLoad()
        self.userName.text = userNameText
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                //do something
                _ = user
        if let url = user?.kakaoAccount?.profile?.profileImageUrl,
            let data = try? Data(contentsOf: url) {
            self.profileImage?.image = UIImage(data: data)
        // Do any additional setup after loading the view.
    }
    

    }
}

    }
    
    @IBAction func settingButtonClicked(_ sender: Any) {
        guard let settingVC = storyboard?.instantiateViewController(identifier: "SettingViewController") as? SettingViewController else {return}
        self.navigationController?.pushViewController(settingVC, animated: true)
        
    }
    
    
    
}
