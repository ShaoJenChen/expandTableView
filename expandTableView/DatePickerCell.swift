//
//  DatePickerCell.swift
//  ExpandTableView
//
//  Created by 陳劭任 on 2019/4/16.
//  Copyright © 2019 陳劭任. All rights reserved.
//

import UIKit

class DatePickerCell: SJExpandCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let dateFormatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = .black
        
        self.datePicker.locale = Locale(identifier: "zh-TW")
        
        self.datePicker.setValue(UIColor.white, forKey: "textColor")
        
        self.dateFormatter.dateFormat = "yyyy / MM / dd  HH:mm"
        
        self.dateLabel.text = self.dateFormatter.string(from: Date())
                
        self.cellHeightConstraint.constant = self.titleHeightConstraint.constant
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        
        let pickerDate = sender.date
        
        let dateStr = self.dateFormatter.string(from: pickerDate)
        
        self.dateLabel.text = dateStr
        
    }
}
