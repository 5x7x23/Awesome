import UIKit
import FSCalendar
import EventKit

class CallendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var monthDay: UILabel!
    var yearData : String = "2021"
    var monthData : String = "05"
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var plusScheduleButton: UIButton!
    @IBOutlet weak var notScheduleButton: UIButton!
    @IBOutlet weak var ScheduleButton: UIButton!
    @IBOutlet weak var scheduleTableView: UITableView!
    var checkDate : String = "2021-05-05"
    let eventStore = EKEventStore()
    var isEvent :Bool = false
   
    
    
    lazy var scheduleButtons: [UIButton] = [self.plusScheduleButton, self.notScheduleButton]
    var isShowFloating: Bool = false
    var isSchedule:Bool = false
   
    var dummySData : [scheduleDummy] = []
    var Userevents : [Date] = []
    
    func setDummydata(){
        if checkDate == "2021-06-08"{
            isSchedule = true
            dummySData = []
            dummySData.append(contentsOf:[scheduleDummy(name: "이민규", time: "11:00 ~ 12:00", icon: "continueIcon") , scheduleDummy(name: "백종원", time: "13:00 ~ 15:00", icon: "continueIcon")
            ])
        }
        else {
            let nowdate = Date()
            let enddate = Calendar.current.date(byAdding: .day, value: 30, to: nowdate)
            let startDate = Calendar.current.date(byAdding: .day, value: -30, to: nowdate)
        let weekFromNow = Date().advanced(by: 30.0)
            let predicate = eventStore.predicateForEvents(withStart: startDate!, end: enddate!, calendars: nil)
            isSchedule = true
            dummySData = []
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
                dummySData.append(contentsOf:[scheduleDummy(name: event.title, time: startTime + comma + finishTime, icon: "continueIcon")])
                    Userevents.append(event.startDate)
                print("dd", event)
                }
        }
        }
       
    }
    
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
    //캘린더 불러오기
    func requestAccess() {
            eventStore.requestAccess(to: .event) { (granted, error) in
                if granted {
                    DispatchQueue.main.async {
                        // load events
                        self.setUserEvent()
                    }
                }
            }
    }
    func setUserEvent(){
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarSet()
        calendar.delegate = self
        calendar.dataSource = self
        self.view.sendSubviewToBack(scheduleTableView)
        self.view.sendSubviewToBack(calendar)
        self.view.sendSubviewToBack(headerView)
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        scheduleTableView.separatorStyle = .none
        setDummydata()
        setUpEvents()
        setUserEvent()
        requestAccess()
    }
    func calendarSet(){
        calendar.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        calendar.appearance.headerDateFormat = ""
        calendar.calendarWeekdayView.weekdayLabels[0].text = "Su"
        calendar.calendarWeekdayView.weekdayLabels[1].text = "Mo"
        calendar.calendarWeekdayView.weekdayLabels[2].text = "Tu"
        calendar.calendarWeekdayView.weekdayLabels[3].text = "We"
        calendar.calendarWeekdayView.weekdayLabels[4].text = "Th"
        calendar.calendarWeekdayView.weekdayLabels[5].text = "Fr"
        calendar.calendarWeekdayView.weekdayLabels[6].text = "Sa"
        labelChanged(yearD: yearData, monthD: monthData)
    }
    
    func refreshControl(){
        scheduleTableView.refreshControl = UIRefreshControl()
    }
    
    public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
          let yearFormatter = DateFormatter()
          yearFormatter.dateFormat = "YYYY"
        yearData = yearFormatter.string(from: date)
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MM"
        monthData = monthFormatter.string(from: date)
        labelChanged(yearD: yearData, monthD: monthData)
        let checkSchedule = DateFormatter()
        checkSchedule.dateFormat = "YYYY-MM-dd"
        checkDate = checkSchedule.string(from: date)
        print(checkDate)
        setDummydata()
        printEventCell()
        scheduleTableView.reloadData()
        
      }
   
    
    

    func labelChanged(yearD : String, monthD : String){
        year.text = yearD
        monthDay.text = monthD
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

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


extension CallendarViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath : IndexPath) -> CGFloat{
        return 60
    }
}


extension CallendarViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSchedule == true{
            return dummySData.count
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
            dummyScheduleCell.setData(nameData: dummySData[indexPath.row].name, timedata: dummySData[indexPath.row].time, scIcon: dummySData[indexPath.row].icon)
            return dummyScheduleCell
        }
        if isSchedule == false{
            return noScheduleCell
        }
        
        
        return UITableViewCell()
    }
    func setUpEvents() {
        let nowdate = Date()
        let enddate = Calendar.current.date(byAdding: .day, value: 30, to: nowdate)
        let startDate = Calendar.current.date(byAdding: .day, value: -30, to: nowdate)
    let weekFromNow = Date().advanced(by: 30.0)
        let predicate = eventStore.predicateForEvents(withStart: startDate!, end: enddate!, calendars: nil)
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.dateFormat = "yyyy-MM-dd"
    let xmas = formatter.date(from: "2020-12-25")
    let userDate = formatter.date(from: "2021-06-08")
    Userevents = [xmas!, userDate!]
    let events = eventStore.events(matching: predicate)
        let UpdateFormatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
        for event in events {
            Userevents.append(event.startDate)
        }
    }
    func printEventCell(){
       
        
    }

    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.Userevents.contains(date){
            print("꽥",Userevents)
            return 5
        }
        return 0
    }
}

