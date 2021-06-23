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
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var plusScheduleButton: UIButton!
    @IBOutlet weak var notScheduleButton: UIButton!
    @IBOutlet weak var ScheduleButton: UIButton!
    @IBOutlet weak var calendarHeaderView: UIView!
    @IBOutlet weak var calendarHeaderViewConstraints: NSLayoutConstraint!
    
    lazy var scheduleButtons: [UIButton] = [self.plusScheduleButton, self.notScheduleButton]
    var isShowFloating: Bool = false
    
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
    public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            let yearFormatter = DateFormatter()
            yearFormatter.dateFormat = "YYYY"
            yearData = yearFormatter.string(from: date)
            
        let monthFormatter = DateFormatter()
            monthFormatter.dateFormat = "MM"
            monthData = monthFormatter.string(from: date)
        
          }
       
    func labelChange(yearD : String, monthD:String) {
        yearLabel.text = yearD
        monthLabel.text = monthD
    }
}



//MARK: - Extention
extension CallendarViewController: FSCalendarDelegate, FSCalendarDataSource{
    
}
extension CallendarViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

