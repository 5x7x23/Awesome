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
        setDummydata()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
    
    //이벤트 관리 함수
    func setDummydata(){
        
        if checkDate == "2021-07-02"{
            isSchedule = true
            scheduleData = []
            scheduleData.append(contentsOf:[scheduleDummy(name: "이민규", time: "11:00 ~ 12:00", icon: "continueIcon") , scheduleDummy(name: "백종원", time: "13:00 ~ 15:00", icon: "continueIcon")
            ])
        }
        else{
            isSchedule = false
        }
       
    }
}



//MARK: - Extention
extension CallendarViewController: FSCalendarDelegate, FSCalendarDataSource{
    
    public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        scheduleTableview.reloadData()
        setDummydata()
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
          }
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.Userevents.contains(date){
            print("꽥",Userevents)
            return 1
        }
        return 0
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
            dummyScheduleCell.setData(nameData: scheduleData[indexPath.row].name, timedata: scheduleData[indexPath.row].time, scIcon: scheduleData[indexPath.row].icon)
            return dummyScheduleCell
        }
        if isSchedule == false{
            return noScheduleCell
        }
        return UITableViewCell()
    }
}
