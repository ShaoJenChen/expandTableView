//
//  SJExpandCell.swift
//  expandTableView
//
//  Created by 陳劭任 on 2019/4/20.
//  Copyright © 2019 ShaoJenChen. All rights reserved.
//

import UIKit

class SJExpandCell: BaseCell {
    
    @IBOutlet weak var arrowIndicator: UIImageView!
    
    @IBOutlet weak var titleHeightConstraint: NSLayoutConstraint!
    
    var isExpanded: Bool = false
    
    var totalHeight: CGFloat!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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


}
