//
//  SingleSelectCell.swift
//  expandTableView
//
//  Created by ShaoJen Chen on 2019/4/18.
//  Copyright © 2019 ShaoJenChen. All rights reserved.
//

import UIKit

protocol SingleSelectProtocol {
    
    func didSelect(index: Int?)
    
}

class SingleSelectCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var selectedItemLabel: UILabel!
    
    var selectOpinions: [String]?
    
    var selectedIndex: Int?
    
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

extension SingleSelectCell: SingleSelectProtocol {
    
    func didSelect(index: Int?) {
        
        if let index = index,
            let opinions = self.selectOpinions {
            
            self.selectedIndex = index
            
            self.selectedItemLabel.text = opinions[index]
            
        }
        
    }
    
}
