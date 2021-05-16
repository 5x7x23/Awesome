//
//  MainTableViewCell.swift
//  Awesome
//
//  Created by 박익범 on 2021/05/02.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    static let identifier : String = "MainTableViewCell"
    
    @IBOutlet weak var cellBackGround: UIImageView!
    @IBOutlet weak var informationimage: UIImageView!
    @IBOutlet weak var scInformation: UILabel!
    @IBOutlet weak var scName: UILabel!
    @IBOutlet weak var timeAgo: UILabel!
    
    public static var ifPromise : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tintColor = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("셀 선택")

        // Configure the view for the selected state
    }
    
    func setData(name : String , information : String, informationImage : String, time : String, backGround : String){
        if let image = UIImage(named: informationImage){
            informationimage.image = image
        }
        if let backgroundImage = UIImage(named: backGround){
            cellBackGround.image = backgroundImage
        }
        scName.text = name
        scInformation.text = information
        timeAgo.text = time
    }

}
