//
//  LoginCheckViewController.swift
//  Awesome
//
//  Created by 박익범 on 2021/04/27.
//

import UIKit
import KakaoSDKUser

class LoginCheckViewController: UIViewController , data {
    func deleteData() {
        dummyData.removeFirst()
        mainTableView.reloadData()
        noSchedule()
    }
    @IBOutlet weak var awesomeLabel: UILabel!
    @IBOutlet weak var HiLabel: UILabel!
    @IBOutlet weak var awesomeLabel2: UILabel!
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var userName: UILabel!
    
    var userNameText : String = ""
    var urlProfile : String = ""
    let screenWith = UIScreen.main.bounds.width
    
    var ifPromise : Bool = false
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var dummyData : [mainViewDummy] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uppdateProfile()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .none
        setDummydata()
        print(HiLabel.font.fontName)
        profileImageRound()
        HiLabel.font = HiLabel.font.withSize(resolutionFontSize(size: 24))
        userName.font = userName.font.withSize(resolutionFontSize(size: 24))
        awesomeLabel.font = awesomeLabel.font.withSize(resolutionFontSize(size: 18))
        awesomeLabel2.font = awesomeLabel2.font.withSize(resolutionFontSize(size: 18))

       

    }
    func noSchedule(){
        if dummyData.count == 0{
            mainTableView.backgroundView = UIImageView(image: UIImage(named: "mainNoSCBackground.png"))
            print("배경변경")
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        uppdateProfile()
        }
    override func viewWillAppear(_ animated: Bool) {
        uppdateProfile()
    }
    
    func profileImageRound(){
        self.profileImageButton?.layer.borderWidth = 1
        self.profileImageButton?.layer.masksToBounds = false
        self.profileImageButton?.layer.borderColor = UIColor.clear.cgColor
        self.profileImageButton?.layer.cornerRadius = profileImageButton.frame.height/2
        self.profileImageButton?.clipsToBounds = true
        let scale = screenWith/428
        self.profileImageButton?.frame.size = CGSize(width: profileImageButton.frame.width * scale, height: profileImageButton.frame.height * scale)
    }
    func resolutionFontSize(size : CGFloat) -> CGFloat{
        let sizeFormatter = size/428
        let result = screenWith * sizeFormatter
        return result
    }

    func setDummydata(){
        dummyData.append(contentsOf:[mainViewDummy(informationImage: "calendar", name: "2021년 6월 7일", information: "IKK 안녕하세요. ethan입니다~ 팀원분들과 점심식사 하시고, 타운홀에서 커피한잔 어떠신가요?", time: "10mAgo", person: "ethan"), mainViewDummy(informationImage: "calendar", name: "2021년 6월 8일", information: "익범 난데 이따 사회적 거리두기 준수하에 간술 어때", time: "10mAgo",person: "이민규"), mainViewDummy(informationImage: "calendar", name: "2021년 6월 5일", information: "피시방 가서 게임하다가 BHC가서 치킨먹고 할리스가서 커피 한잔 하고 장암동에서 빠이빠이 하자. 내 전화번호는 010-5555-5555", time: "1mAgo",person: "이민규"), mainViewDummy(informationImage: "message", name: "If i die tommorow", information: "오늘밤이 만약 내게 주어진 돛대와 같다면 whiat should i do with this mmmm maybe 지나온 나날들을 시원하게 훑겠지 스물 여섯 컷의 흑백 film 내 머릿속의 스케치", time: "Long Time Ago",person: "빈지노")
        ])
        
    }
    
    
    @IBAction func settingButtonClicked(_ sender: Any) {
        guard let settingVC = storyboard?.instantiateViewController(identifier: "SettingViewController") as? SettingViewController else {return}
        self.navigationController?.pushViewController(settingVC, animated: true)
    }
    func dataUrl(){
        
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
                    let profileimage = UIImage(data: data)
                    self.profileImageButton?.setBackgroundImage(profileimage, for: .normal)
                    
                }
            }
               
    }
    }

    
    @IBAction func calendarButtonClicked(_ sender: Any) {
        guard let calendarVC = storyboard?.instantiateViewController(identifier: "CallendarViewController") as? CallendarViewController else {return}
        
        self.navigationController?.pushViewController(calendarVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        mainTableView.deselectRow(at: indexPath, animated: true)
        guard let promiseVC = storyboard?.instantiateViewController(identifier: "PromiseAlertViewController") as? PromiseAlertViewController else {return}
        guard let commentVC = storyboard?.instantiateViewController(identifier: "CommentAlertViewController") as? CommentAlertViewController else {return}
        
        if dummyData[indexPath.row].informationImage == "calendar"{
            self.present(promiseVC, animated: true, completion: nil)
            promiseVC.setData(name: dummyData[indexPath.row].name, information: dummyData[indexPath.row].information, person: dummyData[indexPath.row].person)
            promiseVC.deleteDelegate = self
        }
        else{
            self.present(commentVC, animated: true, completion: nil)
            commentVC.deleteDelegate = self
        }
        
    }
}
extension LoginCheckViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath : IndexPath) -> CGFloat{
        return 110
    }
}
extension LoginCheckViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dummyCell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else {return UITableViewCell() }

        dummyCell.setData(name: dummyData[indexPath.row].name, information: dummyData[indexPath.row].information, informationImage: dummyData[indexPath.row].informationImage, time: dummyData[indexPath.row].time)
        
        
        return dummyCell
    }
    
    
}

