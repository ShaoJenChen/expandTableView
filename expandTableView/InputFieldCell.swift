//
//  InputFieldCell.swift
//  expandTableView
//
//  Created by ShaoJen Chen on 2019/4/19.
//  Copyright © 2019 ShaoJenChen. All rights reserved.
//

import UIKit

class InputFieldCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var inputField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
