//
//  GvExpandTableViewController.swift
//  ExpandTableView
//
//  Created by 陳劭任 on 2019/4/16.
//  Copyright © 2019 陳劭任. All rights reserved.
//

import UIKit

class GvExpandTableViewController: UIViewController {
    
    @IBOutlet weak var GvExpandTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.GvExpandTableView.tableFooterView = UIView()
        
    }
    
}

// MARK: Create Cell

extension GvExpandTableViewController {
    
    private func getDatePickerCell(_ tableView: UITableView, title: String) -> GvDatePickerCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DatePickerCell") as! GvDatePickerCell
        
        cell.titleLabel.text = title
        
        return cell
        
    }
    
    private func getSingleSelectCell(_ tableView: UITableView, indexPath: IndexPath, title: String, opinions: [String]? ) -> SingleSelectCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SingleSelectCell") as! SingleSelectCell
        
        cell.selectOpinions = opinions
        
        cell.titleLabel.text = title
        
        cell.indexPath = indexPath
        
        if let selectedIndex = cell.selectedIndex,
            let opinions = cell.selectOpinions {
            
            cell.selectedItemLabel.text = opinions[selectedIndex]
            
        }
        else {
            
            cell.selectedItemLabel.text = ""
            
        }
        
        return cell
        
    }
    
    private func getInputFieldCell(_ tableView: UITableView, title: String, placeHolder: String) -> InputFieldCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InputFieldCell") as! InputFieldCell
        
        cell.tableView = tableView
        
        cell.titleLabel.text = title
        
        cell.placeHolder = placeHolder
        
        return cell
        
    }
    
}

//MARK: HandleAnimate

extension GvExpandTableViewController {
    
    func expandCollapseAnimate(_ tableView: UITableView, indexPath: IndexPath) {
        
        tableView.beginUpdates()
        
        guard let visibleIndexPaths = tableView.indexPathsForVisibleRows else {  tableView.endUpdates(); return }
        
        for visibleIndexPath in visibleIndexPaths {
            
            if let cell = tableView.cellForRow(at: visibleIndexPath) as? GvDatePickerCell {
                
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

extension GvExpandTableViewController {
    
    func presentSingleSelectViewController(from singleSelectCell: SingleSelectCell) {
        
        self.performSegue(withIdentifier: "singleSelectViewSegue", sender: singleSelectCell)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let viewController = segue.destination as? SingleSelectViewController,
            let cell = sender as? SingleSelectCell,
            segue.identifier == "singleSelectViewSegue" {
            
            viewController.delegate = cell
            
            viewController.selectedIndex = cell.selectedIndex
            
            viewController.opinions = cell.selectOpinions
            
        }
        
    }
    
}

extension GvExpandTableViewController: UITableViewDataSource {
    
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
            
            return self.getSingleSelectCell(tableView, indexPath: indexPath, title: "Camera", opinions: fakeDatas)
            
        case 3:
            // let groups = DeviceConnector.connector.deviceGroupList()
            
            return self.getSingleSelectCell(tableView, indexPath: indexPath, title: "Group", opinions: ["Group1","Group2","Group3"])
            
        case 4:
            return self.getInputFieldCell(tableView, title: "Note1", placeHolder: "InputNote")
            
        case 5:
            return self.getInputFieldCell(tableView, title: "Note2", placeHolder: "InputNote")
            
        default:
            return UITableViewCell()
        }
        
    }
    
}

extension GvExpandTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let cell = tableView.cellForRow(at: indexPath) as? GvDatePickerCell {
            
            if cell.isExpanded {
                
                return cell.totalHeight
                
            }
            else {
                
                return 44.0
                
            }
            
        }
        
        if let cell = tableView.cellForRow(at: indexPath) as? InputFieldCell {
            
            return cell.cellHeightConstraint.constant
            
        }
        else {
            
            return 44.0
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.expandCollapseAnimate(tableView, indexPath: indexPath)
        
        if let cell = tableView.cellForRow(at: indexPath) as? SingleSelectCell {
            
            self.presentSingleSelectViewController(from: cell)
            
        }
        
    }
    
}
