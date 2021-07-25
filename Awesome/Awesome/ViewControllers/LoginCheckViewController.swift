//
//  LoginCheckViewController.swift
//  Awesome
//
//  Created by 박익범 on 2021/04/27.
//

import UIKit


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
    
    let userToken : Any = UserDefaults.standard.object(forKey: "userToken")
    @IBOutlet weak var mainTableView: UITableView!
    let refreshControl = UIRefreshControl()
    
    var dummyData : [mainViewDummy] = []
    var scheduleData: [CalendarDataModel] = []
    
    var scheduleDateString: String = ""
    var titleSchedule: String = ""
    var finishSchedule: String = ""
    var timeAgo: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uppdateProfile()
        setCalendarData()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .none
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
        }
    override func viewWillAppear(_ animated: Bool) {
        
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

//    func setDummydata(){
//        dummyData.append(contentsOf:[mainViewDummy(informationImage: "calendar", name: "2021년 6월 21일", information: "HEY 억만, 내가 분위기 좋은 카페를 찾아놨어 월요일에 시간 괜찮다면 나랑 해방촌에 있는 카페 가지 않겠어? 연락은 집사에게 부탁한다구 010-1234-1234", time: "1mAgo", person: "박순대"), mainViewDummy(informationImage: "calendar", name: "2021년 6월 24일", information: "억만짱,, 바쁘지 않다면,, 이 나랑,, 한잔 하지 않겠,,,어? 나는 마치 29개 짜리 계란 한판 같지,, 한-계란 없그든,,킄", time: "30mAgo",person: "구방장")
//        ])
//
//    }
    
    func setScheduleData(){
        
    }
    
    @IBAction func settingButtonClicked(_ sender: Any) {
        guard let settingVC = storyboard?.instantiateViewController(identifier: "SettingViewController") as? SettingViewController else {return}
        self.navigationController?.pushViewController(settingVC, animated: true)
    }
    func setProfile(){
        self.uppdateProfile()
        let defaults = UserDefaults.standard
        userName.text = defaults.string(forKey: "name") ?? "none"
        
        let url = URL(string: defaults.string(forKey: "profile") ?? "none")
            DispatchQueue.global().async { let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async { self.profileImageButton.setImage(UIImage(data: data!), for: .normal)}}
    }
    
    func uppdateProfile(){
        GetProfileDataService.ProfileData.getRecommendInfo{ (response) in
            switch(response)
            {
            case .success(let loginData):
                self.setProfile()
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
    
    func setCalendarData(){
        GetCalendarDataService.CalendarData.getRecommendInfo{ (response) in
            switch(response)
            {
            case .success(let loginData):
                if let response = loginData as? CalendarDataModel{
                    DispatchQueue.global().async {
                        self.scheduleData.append(response)
                    }
                    self.mainTableView.reloadData()
                }
                print("우가우가", loginData)
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
    
    func changeDate(start: Date, finish: Date, upload: String){
        let startFormatter = DateFormatter()
        let titleFormatter = DateFormatter()
        let finishFormatter = DateFormatter()
        let agoFormatter = DateFormatter()
        var nowDate = Date()
        
        startFormatter.locale = Locale(identifier: "ko_KR")
        startFormatter.dateFormat = "MM월 dd일 HH:mm"
        finishFormatter.locale = Locale(identifier: "ko_KR")
        finishFormatter.dateFormat = "HH:mm"
        titleFormatter.dateFormat = "yyyy년 MM월 dd일"
        agoFormatter.locale = Locale(identifier: "ko_KR")
        agoFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"

        print(upload)
        var startUpload = agoFormatter.date(from: upload)
        let distanceSecond = Calendar.current.dateComponents([.minute], from: startUpload ?? Date(), to: nowDate).minute
        print(startUpload)
        print(distanceSecond, "asgdafasdfeaa")
        
        titleSchedule = titleFormatter.string(from: start)
        finishSchedule = finishFormatter.string(from: start)
        
        scheduleDateString = startFormatter.string(from: start) + "~" + finishFormatter.string(from: finish)
        
        if distanceSecond! < 1{
            timeAgo = "1m ago"
        }
        else if distanceSecond! < 15{
            timeAgo = "15m ago"
        }
        else if distanceSecond! < 30{
            timeAgo = "30m ago"
        }
        else if distanceSecond! < 60{
            timeAgo = "60m ago"
        }
        else{
            timeAgo = "long time ago"
        }
        
    }

    
    @IBAction func calendarButtonClicked(_ sender: Any) {
        guard let calendarVC = storyboard?.instantiateViewController(identifier: "CallendarViewController") as? CallendarViewController else {return}
        self.navigationController?.pushViewController(calendarVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        mainTableView.deselectRow(at: indexPath, animated: true)
        guard let promiseVC = storyboard?.instantiateViewController(identifier: "PromiseAlertViewController") as? PromiseAlertViewController else {return}
      
        
            self.present(promiseVC, animated: true, completion: nil)
        promiseVC.setData(time: scheduleDateString, information: scheduleData[0].myCalendar[indexPath.row].comment, person: scheduleData[0].myCalendar[indexPath.row].creatorName)
        print(scheduleData[0].calendar[indexPath.row].comment)
            promiseVC.deleteDelegate = self
        
    }
}
extension LoginCheckViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath : IndexPath) -> CGFloat{
        return 110
    }
}
extension LoginCheckViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if scheduleData.count == 0{
        return 0
        }
        else{
            return scheduleData[0].myCalendar.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dummyCell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else {return UITableViewCell() }
        print(scheduleData)
        
       
        changeDate(start: scheduleData[0].myCalendar[indexPath.row].startDate, finish: scheduleData[0].myCalendar[indexPath.row].endDate, upload: scheduleData[0].myCalendar[indexPath.row].createdAt)
        dummyCell.setData(name: titleSchedule, information: scheduleData[0].myCalendar[indexPath.row].comment, informationImage: "calendar", time: timeAgo)
        return dummyCell
        
    }
    
    
}
