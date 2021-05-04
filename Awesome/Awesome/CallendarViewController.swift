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
    
    lazy var scheduleButtons: [UIButton] = [self.plusScheduleButton, self.notScheduleButton]
    var isShowFloating: Bool = false
   
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
    }
    
    public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
          let yearFormatter = DateFormatter()
          yearFormatter.dateFormat = "YYYY"
        yearData = yearFormatter.string(from: date)
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MM"
        monthData = monthFormatter.string(from: date)
        labelChanged(yearD: yearData, monthD: monthData)
      }

    func labelChanged(yearD : String, monthD : String){
        year.text = yearD
        monthDay.text = monthD
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
