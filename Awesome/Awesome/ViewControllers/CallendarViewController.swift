import UIKit
import FSCalendar
import EventKit

class CallendarViewController: UIViewController {
//MARK: - var
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var CalendarView: FSCalendar!
    @IBOutlet weak var scheduleTableview: UITableView!
    var yearData : String = ""
    var monthData : String = ""
    var dayData : String = ""
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var plusScheduleButton: UIButton!
    @IBOutlet weak var notScheduleButton: UIButton!
    @IBOutlet weak var ScheduleButton: UIButton!
    @IBOutlet weak var calendarHeaderView: UIView!
    @IBOutlet weak var calendarHeaderViewConstraints: NSLayoutConstraint!
    
    lazy var scheduleButtons: [UIButton] = [self.plusScheduleButton, self.notScheduleButton]
    var isShowFloating: Bool = false
    var isSchedule : Bool = false
    var today = Date()
    var checkDate : String = "2021-07-03"
    let eventStore = EKEventStore()
    var scheduleData : [scheduleDummy] = []
    var Userevents : [Date] = []
    var userEventsDetail: [CalendarDataModel] = []
    
    
//MARK: - 플로팅버튼
    @IBAction func scheduleButtonClicked(_ sender: Any) {
            if isShowFloating == false {
            scheduleButtons.forEach { [weak self] button in
                button.isHidden = false
                button.alpha = 0
                UIView.animate(withDuration: 0.3) {
                    if let image = UIImage(named: "closeButton") {
                        self!.ScheduleButton.setImage(image, for: .normal)
                    }
                    button.alpha = 1
                    self?.view.layoutIfNeeded()
                }
            }
                isShowFloating = true
            }
            else{
            scheduleButtons.reversed().forEach { button in
                UIView.animate(withDuration: 0.3) {
                    if let image = UIImage(named: "schesuleButton") {
                        self.ScheduleButton.setImage(image, for: .normal)
                    }
                    button.isHidden = true
                    self.view.layoutIfNeeded()
                }
            }
                isShowFloating = false
            }

        }
    //뒤로가기
    @IBAction func backButtonClicked(_ sender: Any) {
           self.navigationController?.popViewController(animated: true)
       }
    //배경조절
    func setSizeView(){
        self.scheduleTableview.separatorStyle = .none
        let screenheight = UIScreen.main.bounds.height
        print(screenheight)
        let sizeResolution = screenheight/568
        switch screenheight {
        case 568:
            calendarHeaderViewConstraints.constant = 70
        case 667:
            calendarHeaderViewConstraints.constant = 75
        case 736:
            calendarHeaderViewConstraints.constant = 77
        case 812:
            calendarHeaderViewConstraints.constant = 80
        case 896:
            calendarHeaderViewConstraints.constant = 80
        default:
            calendarHeaderViewConstraints.constant = 80
        }
    }
    
    func setCalendarData(){
        GetCalendarDataService.CalendarData.getRecommendInfo{ (response) in
            switch(response)
            {
            case .success(let loginData):
                if let response = loginData as? CalendarDataModel{
                    DispatchQueue.global().sync {
                        self.userEventsDetail.append(response)
                    }
                    self.serverData()
                    self.CalendarView.reloadData()
                    print(self.Userevents)
                }
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
    
    func serverData(){
        let UpdateFormatter = DateFormatter()
        UpdateFormatter.locale = Locale(identifier: "ko_KR")
        UpdateFormatter.dateFormat = "yyyy-MM-dd"
        for i in 0 ... userEventsDetail[0].myCalendar.count - 1{
            let dateData = UpdateFormatter.string(from: userEventsDetail[0].myCalendar[i].startDate)
            let realData = UpdateFormatter.date(from: dateData)
            
            Userevents.append(realData!)
        }
    }
    
    func setUserEvents(){
        let nowdate = Date()
        let enddate = Calendar.current.date(byAdding: .day, value: 30, to: nowdate)
        let startDate = Calendar.current.date(byAdding: .day, value: -30, to: nowdate)
    let weekFromNow = Date().advanced(by: 30.0)
        let predicate = eventStore.predicateForEvents(withStart: startDate!, end: enddate!, calendars: nil)
            let events = eventStore.events(matching: predicate)
            let UpdateFormatter = DateFormatter()
            UpdateFormatter.locale = Locale(identifier: "ko_KR")
            UpdateFormatter.dateFormat = "yyyy-MM-dd"
            for event in events {
                let dateData = UpdateFormatter.string(from: event.startDate!)
                let realData = UpdateFormatter.date(from: dateData)
                Userevents.append(realData!)
            }
      
    }

//MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.sendSubviewToBack(scheduleTableview)
        self.view.sendSubviewToBack(CalendarView)
        self.view.sendSubviewToBack(headerView)
        CalendarView.delegate = self
        CalendarView.dataSource = self
        scheduleTableview.delegate = self
        scheduleTableview.dataSource = self
        todayDate()
        setSizeView()
        calendarSet() // 날짜 및 디자인 세팅
        requestAccess()
        setdate()
        setUserEvents()
      

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setCalendarData()
    }
    //MARK: funcSet
    //초기 날짜설정
    func todayDate(){
        let today = Date()
        let Yearformatter = DateFormatter()
        Yearformatter.dateFormat = "YYYY"
        yearData = Yearformatter.string(from: today)
        let monthformatter = DateFormatter()
        monthformatter.dateFormat = "MM"
        monthData = monthformatter.string(from: today)
        
        labelChange(yearD: yearData, monthD: monthData)
    }

    func calendarSet(){
        CalendarView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        CalendarView.appearance.headerDateFormat = ""
        CalendarView.calendarWeekdayView.weekdayLabels[0].text = "Su"
        CalendarView.calendarWeekdayView.weekdayLabels[1].text = "Mo"
        CalendarView.calendarWeekdayView.weekdayLabels[2].text = "Tu"
        CalendarView.calendarWeekdayView.weekdayLabels[3].text = "We"
        CalendarView.calendarWeekdayView.weekdayLabels[4].text = "Th"
        CalendarView.calendarWeekdayView.weekdayLabels[5].text = "Fr"
        CalendarView.calendarWeekdayView.weekdayLabels[6].text = "Sa"
        CalendarView.firstWeekday = 1
        }
    
    //날짜 선택시
   
    //라벨 변경 함수
    func labelChange(yearD : String, monthD:String) {
        yearLabel.text = yearD
        monthLabel.text = monthD

    }
    
    
    func setdate(){
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-mm-DD"
//        let convertDate = dateFormatter.date(from: checkDate)
        let checkDateConvert = checkDate
        let nowdate = Date()
        let enddate = Calendar.current.date(byAdding: .day, value: 30, to: nowdate)
        let startDate = Calendar.current.date(byAdding: .day, value: -30, to: nowdate)
        let weekFromNow = Date().advanced(by: 30.0)
              let predicate = eventStore.predicateForEvents(withStart: startDate!, end: enddate!, calendars: nil)
            scheduleData = []
              let events = eventStore.events(matching: predicate)
              let formatter = DateFormatter()
              let startTimeFormatter = DateFormatter()
              let finishTimeFormatter = DateFormatter()
              formatter.locale = Locale(identifier: "ko_KR")
              formatter.dateFormat = "yyyy-MM-dd"
              startTimeFormatter.dateFormat = "HH:mm"
              finishTimeFormatter.dateFormat = "HH:mm"
              let comma : String = " ~ "
            
        for event in events {
                  let start = formatter.string(from: event.startDate)
                  let startTime = startTimeFormatter.string(from: event.startDate)
                  let finishTime = finishTimeFormatter.string(from: event.endDate)
            if checkDate == start{
                    scheduleData.append(contentsOf:[scheduleDummy(name: event.title, time: startTime + comma + finishTime, icon: "continueIcon")])
                      Userevents.append(event.startDate)
                  print("dd", scheduleData)
                scheduleTableview.reloadData()
                  }
            if scheduleData.count != 0{
            isSchedule = true
            }
            else{
            isSchedule = false
            }
          }
        
        if userEventsDetail.count != 0{
        for userEvents in userEventsDetail[0].myCalendar{
            let start = formatter.string(from: userEvents.startDate)
            let startTime = startTimeFormatter.string(from: userEvents.startDate)
            let finishTime = finishTimeFormatter.string(from: userEvents.endDate)
            if checkDate == start{
                scheduleData.append(contentsOf:[scheduleDummy(name: userEvents.comment, time: startTime + comma + finishTime, icon: "continueIcon")])
//                  Userevents.append(userEvents.startDate)
              print("dd", scheduleData)
                scheduleTableview.reloadData()
            }
            if scheduleData.count != 0{
            isSchedule = true
            }
            else{
            isSchedule = false
            }
        }
        }
        
        
    }
    
        func requestAccess() {
                eventStore.requestAccess(to: .event) { (granted, error) in
                    if granted {
                        DispatchQueue.main.async {
                            // load events
                        }
                    }
                }
        }
    //이벤트 관리 함수

    @IBAction func plusScheduleButtonClicked(_ sender: Any) {
        guard let plusVC = storyboard?.instantiateViewController(identifier: "PlusViewController" ) as? PlusViewController else {return}
        self.present(plusVC, animated: true, completion: nil)
    }
    @IBAction func notScheduleButtonCliecked(_ sender: Any) {
        guard let notVC = storyboard?.instantiateViewController(identifier: "NotScheduleViewController") as? NotScheduleViewController else {return}
        self.present(notVC, animated: true, completion: nil
        )
    }
    
}

//MARK: - Extention
extension CallendarViewController: FSCalendarDelegate, FSCalendarDataSource{
    
    public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        scheduleTableview.reloadData()
        let yearFormatter = DateFormatter()
            yearFormatter.dateFormat = "YYYY"
            yearData = yearFormatter.string(from: date)
            
        let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MM"
            monthData = monthFormatter.string(from: date)
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd"
        dayData = dayFormatter.string(from: date)
        
        labelChange(yearD: yearData, monthD: monthData)
        checkDate = yearData+"-"+monthData+"-"+dayData
        print(checkDate)
        setdate()
          }
    
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if Userevents.contains(date){
            print("dddd")
            return 1
        }
        else{

            return 0
        }
    }
    

    
}
extension CallendarViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath : IndexPath) -> CGFloat{
          return 60
      }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSchedule == true{
                  return scheduleData.count
              }
              else{
                  return 1
              }

    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //약속셀
            guard let dummyScheduleCell = tableView.dequeueReusableCell(withIdentifier: ScheduleTableViewCell.identifier) as? ScheduleTableViewCell else {return UITableViewCell() }
        //특별한 약속이 없네여~
        guard let noScheduleCell = tableView.dequeueReusableCell(withIdentifier: NoScheduleTableViewCell.identifier) else {return UITableViewCell() }
        //스케쥴이 있을때
        if isSchedule == true{
            print("셀실행")
            dummyScheduleCell.setData(nameData: scheduleData[indexPath.row].name, timedata: scheduleData[indexPath.row].time, scIcon: scheduleData[indexPath.row].icon)
            return dummyScheduleCell
        }
        if isSchedule == false{
            print("없는셀 실행")
            return noScheduleCell
        }
        return UITableViewCell()
    }
}
