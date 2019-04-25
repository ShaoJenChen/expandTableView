//
//  SJExpandTableViewController.swift
//  ExpandTableView
//
//  Created by 陳劭任 on 2019/4/16.
//  Copyright © 2019 陳劭任. All rights reserved.
//

import UIKit

class SJExpandTableViewController: UIViewController {
    
    @IBOutlet weak var SJExpandTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.extendedLayoutIncludesOpaqueBars = true
        
        self.SJExpandTableView.tableFooterView = UIView()
        
    }
    
}

// MARK: Create Cell

extension SJExpandTableViewController {
    
    private func getDatePickerCell(_ tableView: UITableView, title: String) -> DatePickerCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DatePickerCell") as! DatePickerCell
        
        cell.titleLabel.text = title
        
        return cell
        
    }
    
    private func getSingleSelectCell(_ tableView: UITableView, title: String, options: [String]? ) -> SingleSelectCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SingleSelectCell") as! SingleSelectCell
        
        cell.selectOptions = options
        
        cell.titleLabel.text = title
        
        cell.parantTable = tableView
        
        cell.selectedItemLabel.text = ""
        
        if let selectedIndex = cell.selectedIndex,
            let options = cell.selectOptions {
            
            cell.selectedItemLabel.text = options[selectedIndex]
            
        }
        
        return cell
        
    }
    
    private func getInputFieldCell(_ tableView: UITableView, indexPath: IndexPath, title: String, placeHolder: String) -> InputFieldCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InputFieldCell") as! InputFieldCell
        
        cell.tableView = tableView
        
        cell.indexPath = indexPath
        
        cell.titleLabel.text = title
        
        cell.placeHolder = placeHolder
        
        return cell
        
    }
    
}

//MARK: HandleAnimate

extension SJExpandTableViewController {
    
    func expandCollapseAnimate(_ tableView: UITableView, indexPath: IndexPath) {
        
        tableView.beginUpdates()
        
        guard let visibleIndexPaths = tableView.indexPathsForVisibleRows else {  tableView.endUpdates(); return }
        
        for visibleIndexPath in visibleIndexPaths {
            
            if let cell = tableView.cellForRow(at: visibleIndexPath) as? SJExpandCell {
                
                if !cell.isExpanded && visibleIndexPath == indexPath {
                    
                    cell.expand()
                    
                }
                else {
                    
                    cell.collapse()
                    
                }
                
            }
            
        }
        
        tableView.endUpdates()
        
    }
    
}


extension SJExpandTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            return self.getDatePickerCell(tableView, title: "From")
        case 1:
            return self.getDatePickerCell(tableView, title: "To")
            
        case 2:
            // let cameras = DeviceConnector.connector.deviceCameraList()
            
            var fakeDatas = [String]()
            for index in 0...63 {
                fakeDatas.append("Camera\(index)")
            }
            
            return self.getSingleSelectCell(tableView, title: "Camera", options: fakeDatas)
            
        case 3:
            // let groups = DeviceConnector.connector.deviceGroupList()
            
            return self.getSingleSelectCell(tableView, title: "Group", options: ["Group1","Group2","Group3"])
            
        case 4:
            return self.getInputFieldCell(tableView, indexPath: indexPath, title: "Note1", placeHolder: "InputNote")
            
        case 5:
            return self.getInputFieldCell(tableView, indexPath: indexPath, title: "Note2", placeHolder: "InputNote")
            
        default:
            return UITableViewCell()
        }
        
    }
    
}

extension SJExpandTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let cell = tableView.cellForRow(at: indexPath) as? DatePickerCell {
            
            return cell.cellHeightConstraint.constant
            
        }
        
        if let cell = tableView.cellForRow(at: indexPath) as? InputFieldCell {
            
            return cell.cellHeightConstraint.constant
            
        }
        
        if let cell = tableView.cellForRow(at: indexPath) as? SingleSelectCell,
            cell.isExpanded {
            
            let maxHeight = self.view.frame.height * 0.3
            
            let estimateHeight = CGFloat(cell.selectOptions!.count) * 44 + 44
            
            let heightConstant = estimateHeight > maxHeight ? maxHeight : estimateHeight
            
            cell.cellHeightConstraint.constant = heightConstant
            
            return heightConstant
            
        }
        
        return 44.0
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.expandCollapseAnimate(tableView, indexPath: indexPath)
        
    }
    
}
