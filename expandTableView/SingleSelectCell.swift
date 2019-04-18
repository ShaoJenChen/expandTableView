//
//  SingleSelectCell.swift
//  expandTableView
//
//  Created by ShaoJen Chen on 2019/4/18.
//  Copyright © 2019 ShaoJenChen. All rights reserved.
//

import UIKit

class SingleSelectCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var selectedItemLabel: UILabel!
    
    var selectOpinions: [String]?
    
    var selectedIndex: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
