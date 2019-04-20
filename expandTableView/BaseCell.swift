//
//  BaseExpandCell.swift
//  expandTableView
//
//  Created by 陳劭任 on 2019/4/20.
//  Copyright © 2019 ShaoJenChen. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var cellHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
