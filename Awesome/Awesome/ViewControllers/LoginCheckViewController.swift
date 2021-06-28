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

    var loginApple : Bool = false
    var userNameText : String = ""
    var urlProfile : String = ""
    let screenWith = UIScreen.main.bounds.width
    
    var ifPromise : Bool = false
    
    @IBOutlet weak var mainTableView: UITableView!
    let refreshControl = UIRefreshControl()
    
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
    
    func refresh(){
        refreshControl.endRefreshing()
        mainTableView.refreshControl = refreshControl
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
        dummyData.append(contentsOf:[mainViewDummy(informationImage: "calendar", name: "2021년 6월 21일", information: "HEY 억만, 내가 분위기 좋은 카페를 찾아놨어 월요일에 시간 괜찮다면 나랑 해방촌에 있는 카페 가지 않겠어? 연락은 집사에게 부탁한다구 010-1234-1234", time: "1mAgo", person: "박순대"), mainViewDummy(informationImage: "calendar", name: "2021년 6월 24일", information: "억만짱,, 바쁘지 않다면,, 이 나랑,, 한잔 하지 않겠,,,어? 나는 마치 29개 짜리 계란 한판 같지,, 한-계란 없그든,,킄", time: "30mAgo",person: "구방장")
        ])
        
    }
    
    @IBAction func settingButtonClicked(_ sender: Any) {
        guard let settingVC = storyboard?.instantiateViewController(identifier: "SettingViewController") as? SettingViewController else {return}
        self.navigationController?.pushViewController(settingVC, animated: true)
    }
    func dataUrl(){
        
    }
    
    func uppdateProfile(){

    }

    
    @IBAction func calendarButtonClicked(_ sender: Any) {
        guard let calendarVC = storyboard?.instantiateViewController(identifier: "CallendarViewController") as? CallendarViewController else {return}
        self.navigationController?.pushViewController(calendarVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        mainTableView.deselectRow(at: indexPath, animated: true)
        guard let promiseVC = storyboard?.instantiateViewController(identifier: "PromiseAlertViewController") as? PromiseAlertViewController else {return}
      
        
        if dummyData[indexPath.row].informationImage == "calendar"{
            self.present(promiseVC, animated: true, completion: nil)
            promiseVC.setData(name: dummyData[indexPath.row].name, information: dummyData[indexPath.row].information, person: dummyData[indexPath.row].person)
            promiseVC.deleteDelegate = self
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

