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
    }
    @IBOutlet weak var awesomeLabel: UILabel!
    @IBOutlet weak var HiLabel: UILabel!
    @IBOutlet weak var awesomeLabel2: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var userName: UILabel!
    var userNameText : String = ""
    var urlProfile : String = ""
    
    var ifPromise : Bool = false
    
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
        HiLabel.dynamicFont(fontSize: 24, weight: .semibold)
        print(HiLabel.font.fontName)
        awesomeLabel2.dynamicFont(fontSize: 18, weight: .black)
        awesomeLabel.dynamicFont(fontSize: 18, weight: .black)
        userName.dynamicFont(fontSize: 24, weight: .semibold)
    }
    override func viewDidAppear(_ animated: Bool) {
        uppdateProfile()
        }
    override func viewWillAppear(_ animated: Bool) {
        uppdateProfile()
    }
    
    func setDummydata(){
        dummyData.append(contentsOf:[mainViewDummy(informationImage: "calendar", name: "2021년 5월 7일", information: "IKK 안녕하세요. ethan입니다~ 팀원분들과 점심식사 하시고, 타운홀에서 커피한잔 어떠신가요?", time: "10mAgo", backgroundImage: "cellBackground",person: "ethan"),mainViewDummy(informationImage: "calendar", name: "2021년 5월 5일", information: "익범 난데 이따 사회적 거리두기 준수하에 간술 어때", time: "10mAgo", backgroundImage: "cellBackground",person: "이민규"), mainViewDummy(informationImage: "calendar", name: "2021년 5월 13일", information: "피시방 가서 게임하다가 BHC가서 치킨먹고 할리스가서 커피 한잔 하고 장암동에서 빠이빠이 하자. 내 전화번호는 010-5555-5555", time: "1mAgo", backgroundImage: "cellBackground",person: "이민규"),
                                     mainViewDummy(informationImage: "message", name: "If i die tommorow", information: "오늘밤이 만약 내게 주어진 돛대와 같다면 whiat should i do with this mmmm maybe 지나온 나날들을 시원하게 훑겠지 스물 여섯 컷의 흑백 film 내 머릿속의 스케치", time: "Long Time Ago", backgroundImage: "cellBackground",person: "빈지노")
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
        }
        
    }
}
extension LoginCheckViewController : UITableViewDelegate{
    func tableview(_ tableView: UITableView, heightForRowAt indexPath : IndexPath) -> CGFloat{
        return 100
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

extension UILabel {
  func dynamicFont(fontSize size: CGFloat, weight: UIFont.Weight) {
    let currentFontName = "GmarketSansTTFBold"
    var calculatedFont: UIFont?
    let bounds = UIScreen.main.bounds
    let height = bounds.size.height
    
    switch height {
    case 568.0: //iphone 5, SE => 4 inch
      calculatedFont = UIFont(name: currentFontName, size: size * 0.7)
      resizeFont(calculatedFont: calculatedFont, weight: weight)
      break
    case 667.0: //iphone 6, 6s, 7, 8 => 4.7 inch
      calculatedFont = UIFont(name: currentFontName, size: size * 0.92)
      resizeFont(calculatedFont: calculatedFont, weight: weight)
      break
    case 736.0: //iphone 6s+ 6+, 7+, 8+ => 5.5 inch
      calculatedFont = UIFont(name: currentFontName, size: size * 0.95)
     resizeFont(calculatedFont: calculatedFont, weight: weight)
      break
    case 812.0: //iphone X, XS => 5.8 inch
      calculatedFont = UIFont(name: currentFontName, size: size)
      resizeFont(calculatedFont: calculatedFont, weight: weight)
      break
    case 896.0: //iphone XR => 6.1 inch  // iphone XS MAX => 6.5 inch
      calculatedFont = UIFont(name: currentFontName, size: size * 1.15)
      resizeFont(calculatedFont: calculatedFont, weight: weight)
      break
    default:
      print("not an iPhone")
      break
    }
  }
  
  private func resizeFont(calculatedFont: UIFont?, weight: UIFont.Weight) {
    self.font = calculatedFont
    self.font = UIFont.systemFont(ofSize: calculatedFont!.pointSize, weight: weight)
  }
}