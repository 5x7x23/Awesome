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
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var dummyData : [mainViewDummy] = []
    
    override func viewDidLoad() {
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.clear.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        super.viewDidLoad()
        uppdateProfile()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .none
        setDummydata()
        mainTableView.tintColor = .none
        
    }
    override func viewDidAppear(_ animated: Bool) {
        uppdateProfile()
        }
    override func viewWillAppear(_ animated: Bool) {
        uppdateProfile()
    }
    
    func setDummydata(){
        dummyData.append(contentsOf:[mainViewDummy(informationImage: "calendar", name: "2021년 5월 13일", information: "피시방 가서 게임하다가 BHC가서 치킨먹고 할리스가서 커피 한잔 하고 장암동에서 빠이빠이 하자. 내 전화번호는 010-5555-5555", time: "1mAgo", backgroundImage: "cellBackground"),
                                     mainViewDummy(informationImage: "message", name: "If i die tommorow", information: "오늘밤이 만약 내게 주어진 돛대와 같다면 whiat should i do with this mmmm maybe 지나온 나날들을 시원하게 훑겠지 스물 여섯 컷의 흑백 film 내 머릿속의 스케치", time: "Long Time Ago", backgroundImage: "cellBackground")
        ])
    }
    
    
    @IBAction func settingButtonClicked(_ sender: Any) {
        guard let settingVC = storyboard?.instantiateViewController(identifier: "SettingViewController") as? SettingViewController else {return}
        self.navigationController?.pushViewController(settingVC, animated: true)
        
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
extension LoginCheckViewController : UITableViewDelegate{
    func tableview(_ tableView: UITableView, heightForRowAt indexPath : IndexPath) -> CGFloat{
        return 100;
    }
}
extension LoginCheckViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dummyCell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else {return UITableViewCell() }

        dummyCell.setData(name: dummyData[indexPath.row].name, information: dummyData[indexPath.row].information, informationImage: dummyData[indexPath.row].informationImage, time: dummyData[indexPath.row].time, backGround: dummyData[indexPath.row].backgroundImage)
        
        return dummyCell
    }
    
    
}
