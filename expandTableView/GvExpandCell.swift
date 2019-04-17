//
//  GvExpandCell.swift
//  ExpandTableView
//
//  Created by 陳劭任 on 2019/4/16.
//  Copyright © 2019 陳劭任. All rights reserved.
//

import UIKit

class GvExpandCell: UITableViewCell {

    @IBOutlet weak var arrowIndicator: UIImageView!
    
    @IBOutlet weak var cellHeightConstraint: NSLayoutConstraint!
    
    var totalHeight: CGFloat!
    
    var isExpanded: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.totalHeight = self.frame.height
        
        self.cellHeightConstraint.constant = 0
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
            
            self.cellHeightConstraint.constant = CGFloat(44.0)
            
            self.layoutIfNeeded()
            
            self.isExpanded = false
            
        }, completion: { finished in
            
        })
    }
}
