//
//  GvDatePickerCell.swift
//  ExpandTableView
//
//  Created by 陳劭任 on 2019/4/16.
//  Copyright © 2019 陳劭任. All rights reserved.
//

import UIKit

class GvDatePickerCell: UITableViewCell {

    @IBOutlet weak var arrowIndicator: UIImageView!
    
    @IBOutlet weak var titleHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var cellHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var totalHeight: CGFloat!
    
    var isExpanded: Bool = false
    
    let dateFormatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = .black
        
        self.datePicker.setValue(UIColor.white, forKey: "textColor")
        
        self.dateFormatter.dateFormat = "yyyy / MM / dd  HH:mm"
        
        self.dateLabel.text = self.dateFormatter.string(from: Date())
        
        self.totalHeight = self.frame.height
        
        self.cellHeightConstraint.constant = self.titleHeightConstraint.constant
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func expand() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveLinear, animations: {
            
            self.arrowIndicator.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 0.5))
            
            self.cellHeightConstraint.constant = self.totalHeight
            
            self.layoutIfNeeded()
            
            self.isExpanded = true
            
        }, completion: { finished in
            
        })
    }
    
    func collapse() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveLinear, animations: {
            
            self.arrowIndicator.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 0.0))
            
            self.cellHeightConstraint.constant = self.titleHeightConstraint.constant
            
            self.layoutIfNeeded()
            
            self.isExpanded = false
            
        }, completion: { finished in
            
        })
    }
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        
        let pickerDate = sender.date
        
        let dateStr = self.dateFormatter.string(from: pickerDate)
        
        self.dateLabel.text = dateStr
        
    }
}
