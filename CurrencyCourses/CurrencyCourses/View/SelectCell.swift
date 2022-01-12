//
//  SelectCell.swift
//  CurrencyCourses
//
//  Created by Галина Збитнева on 07.04.2021.
//

import UIKit

class SelectCell: UITableViewCell {

    @IBOutlet weak var imageFlag: UIImageView!
    
    @IBOutlet weak var labelCurrencyName: UILabel!
   
    @IBOutlet weak var labelCourse: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func initCellSelected(currency: Currency){
        imageFlag.image = currency.imageFlag
        labelCurrencyName.text = currency.Name
        labelCourse.text = currency.Value
        
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
