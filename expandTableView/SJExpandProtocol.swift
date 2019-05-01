//
//  SJExpandProtocol.swift
//  expandTableView
//
//  Created by 陳劭任 on 2019/4/30.
//  Copyright © 2019 ShaoJenChen. All rights reserved.
//

import UIKit

protocol SJExpandProtocol {
    
    func expandCollapseAnimate(_ tableView: UITableView, indexPath: IndexPath)
    
    func getExpandCellHeight(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    
    func getDatePickerCell(_ tableView: UITableView, title: String) -> DatePickerCell
    
    func getSingleSelectCell(_ tableView: UITableView, title: String, options: [String]?) -> SingleSelectCell
    
    func getInputFieldCell(_ tableView: UITableView, indexPath: IndexPath, title: String, placeHolder: String) -> InputFieldCell
    
    func getMultiImageCell(_ tableView: UITableView, title: String, images: [UIImage]?) -> MultiImageCell
    
}

extension SJExpandProtocol {
    
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
    
    func getExpandCellHeight(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        
        if let cell = tableView.cellForRow(at: indexPath) as? DatePickerCell {
            
            return cell.cellHeightConstraint.constant
            
        }
        
        if let cell = tableView.cellForRow(at: indexPath) as? InputFieldCell {
            
            return cell.cellHeightConstraint.constant
            
        }
        
        if let cell = tableView.cellForRow(at: indexPath) as? SingleSelectCell,
            cell.isExpanded {
            
            let maxHeight = tableView.frame.height * 0.5
            
            let estimateHeight = CGFloat(cell.selectOptions!.count) * 44 + 44
            
            let heightConstant = estimateHeight > maxHeight ? maxHeight : estimateHeight
            
            cell.cellHeightConstraint.constant = heightConstant
            
            return heightConstant
            
        }
        
        return 44.0
        
    }
    
    func getDatePickerCell(_ tableView: UITableView, title: String) -> DatePickerCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DatePickerCell") as! DatePickerCell
        
        cell.titleLabel.text = title
        
        return cell
        
    }
    
    func getSingleSelectCell(_ tableView: UITableView, title: String, options: [String]?) -> SingleSelectCell {
        
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
    
    func getInputFieldCell(_ tableView: UITableView, indexPath: IndexPath, title: String, placeHolder: String) -> InputFieldCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InputFieldCell") as! InputFieldCell
        
        cell.tableView = tableView
        
        cell.indexPath = indexPath
        
        cell.titleLabel.text = title
        
        cell.placeHolder = placeHolder
        
        return cell
        
    }
    
    func getMultiImageCell(_ tableView: UITableView, title: String, images: [UIImage]?) -> MultiImageCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MultiImageCell") as! MultiImageCell
        
        cell.images = images
        
        cell.titleLabel.text = title
        
        return cell
        
    }
    
}
