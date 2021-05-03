//
//  CallendarViewController.swift
//  Awesome
//
//  Created by 박익범 on 2021/05/03.
//

import UIKit
import FSCalendar

class CallendarViewController: UIViewController {
    @IBOutlet weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.backgroundColor = UIColor(red: 241, green: 239, blue: 228, alpha: 1)

        // Do any additional setup after loading the view.
    }

    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
