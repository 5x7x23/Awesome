import UIKit
import FSCalendar

class CallendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
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
    
    lazy var scheduleButtons: [UIButton] = [self.plusScheduleButton, self.notScheduleButton]
    var isShowFloating: Bool = false
   
    var dummySData : [scheduleDummy] = []
    
    func setDummydata(){
        if checkDate != "2021-05-05"{
            if checkDate == "2021-05-07"{
                dummySData = []
                dummySData.append(contentsOf:[scheduleDummy(name: "ethan", time: "14:00 ~ 15:00", icon: "continueIcon", clear:"")
                ])
                
            }
            else{
            dummySData = []
            dummySData.append(contentsOf:[scheduleDummy(name: "", time: "", icon: "clearIcon", clear:"🙄 특별히 약속이 없네요 🙄️")
            ])
            print("hihihi")
            }
        }
            else{
                dummySData = []
        dummySData.append(contentsOf:[scheduleDummy(name: "이민규", time: "11:00 ~ 12:00", icon: "continueIcon", clear:"") , scheduleDummy(name: "백종원", time: "13:00 ~ 15:00", icon: "continueIcon",clear:"")
        ])
                print("byebyebye")
            }
    }
    
    @IBAction func scheduleButtonClicked(_ sender: Any) {
        if isShowFloating == false {
        scheduleButtons.forEach { [weak self] button in
            button.isHidden = false
            button.alpha = 0
            UIView.animate(withDuration: 0.3) {
                button.alpha = 1
                self?.view.layoutIfNeeded()
            }
        }
            isShowFloating = true
        }
        else{
        scheduleButtons.reversed().forEach { button in
            UIView.animate(withDuration: 0.3) {
                button.isHidden = true
                self.view.layoutIfNeeded()
            }
        }
            isShowFloating = false
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.dataSource = self
        calendar.backgroundColor = UIColor(red: 241/255, green: 239/255, blue: 228/255, alpha: 1)
        calendar.appearance.headerDateFormat = ""
        calendar.appearance.weekdayFont = UIFont(name: "NotoSans-Regular", size: 14)
        calendar.calendarWeekdayView.weekdayLabels[0].text = "Su"
        calendar.calendarWeekdayView.weekdayLabels[1].text = "Mo"
        calendar.calendarWeekdayView.weekdayLabels[2].text = "Tu"
        calendar.calendarWeekdayView.weekdayLabels[3].text = "We"
        calendar.calendarWeekdayView.weekdayLabels[4].text = "Th"
        calendar.calendarWeekdayView.weekdayLabels[5].text = "Fr"
        calendar.calendarWeekdayView.weekdayLabels[6].text = "Sa"
        calendar.appearance.titleFont = UIFont(name: "NotoSans-Regular", size: 14)
        labelChanged(yearD: yearData, monthD: monthData)
        self.view.sendSubviewToBack(scheduleTableView)
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        scheduleTableView.separatorStyle = .none
        setDummydata()
        print("viewdidload")

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
}


extension CallendarViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath : IndexPath) -> CGFloat{
        return 60
    }
}


extension CallendarViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dummySData.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let dummyScheduleCell = tableView.dequeueReusableCell(withIdentifier: ScheduleTableViewCell.identifier, for: indexPath) as? ScheduleTableViewCell else {return UITableViewCell() }
        
            dummyScheduleCell.setData(nameData: dummySData[indexPath.row].name, timedata: dummySData[indexPath.row].time, scIcon: dummySData[indexPath.row].icon, clearCell: dummySData[indexPath.row].clear)
        return dummyScheduleCell
    }
    
}


