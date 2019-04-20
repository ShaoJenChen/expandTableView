//
//  SingleSelectCell.swift
//  expandTableView
//
//  Created by ShaoJen Chen on 2019/4/18.
//  Copyright © 2019 ShaoJenChen. All rights reserved.
//

import UIKit

class SingleSelectCell: SJExpandCell {
    
    @IBOutlet var selectedItemLabel: UILabel!
    
    @IBOutlet weak var optionsTableView: UITableView!
    
    var selectOptions: [String]?
    
    var selectedIndex: Int?
    
    var parantTable: UITableView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
        self.optionsTableView.tableFooterView = UIView()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

extension SingleSelectCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let count = self.selectOptions?.count else { return 0 }
        
        return count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell") as? OptionCell else { return UITableViewCell() }
        
        if let options = self.selectOptions {
            
            cell.optionLabel.text = options[indexPath.row]
            
            guard indexPath.row == self.selectedIndex else { cell.accessoryType = .none; return cell }
            
            cell.accessoryType = .checkmark
            
            return cell
            
        }
        
        return cell
        
    }
    
}

extension SingleSelectCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedIndex = indexPath.row
        
        self.selectedItemLabel.text = self.selectOptions![indexPath.row]
        
        self.collapse()
        
        self.optionsTableView?.reloadData()
        
        self.parantTable?.beginUpdates()
        
        self.parantTable?.endUpdates()

    }
    
}
