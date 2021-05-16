//
//  ScheduleTableViewCell.swift
//  Awesome
//
//  Created by 박익범 on 2021/05/04.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var scheduleIcon: UIImageView!
    @IBOutlet weak var time: UILabel!
    static let identifier : String = "ScheduleTableViewCell"
    @IBOutlet weak var clearLabel: UILabel!
    @IBOutlet weak var downView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(nameData : String, timedata : String, scIcon: String, clearCell: String){
        if let image = UIImage(named: scIcon){
            scheduleIcon.image = image
        }
        name.text = nameData
        time.text = timedata
        clearLabel.text = clearCell
       
    }
}
