//
//  CourseCell.swift
//  CurrencyCourses
//
//  Created by Галина Збитнева on 06.04.2021.
//

import UIKit

class CourseCell: UITableViewCell {

    @IBOutlet weak var imageFlag: UIImageView!
    @IBOutlet weak var labelCurrencyName: UILabel!
    @IBOutlet weak var labelCourse: UILabel!
    
    func initCell(currencu: Currency){
        imageFlag.image = currencu.imageFlag
        labelCurrencyName.text = currencu.Name
        labelCourse.text = currencu.Value
        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
