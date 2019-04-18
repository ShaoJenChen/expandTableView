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
    
    private func getDatePickerCell(_ tableView: UITableView, indexPath: IndexPath) -> GvDatePickerCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DatePickerCell") as! GvDatePickerCell
        
        if indexPath.row == 0 { cell.titleLabel.text = "From" }
        
        if indexPath.row == 1 { cell.titleLabel.text = "To" }
        
        return cell
        
    }
    
    private func getSingleSelectCell(_ tableView: UITableView, indexPath: IndexPath) -> SingleSelectCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SingleSelectCell") as! SingleSelectCell

        if indexPath.row == 2 {
            
//            cell.selectOpinions = DeviceConnector.connector.deviceCameraList()
            
            var fakeDatas = [String]()
            for index in 0...63 {
                fakeDatas.append("Camera\(index)")
            }
            
            cell.selectOpinions = fakeDatas
            
            cell.titleLabel.text = "Camera"
            
        }
        
        if indexPath.row == 3 {
            
//            cell.selectOpinions = DeviceConnector.connector.deviceGroupList()
            
            cell.selectOpinions = ["Group1", "Group2", "Group3"]
            
            cell.titleLabel.text = "Group"
            
        }

        if let selectedIndex = cell.selectedIndex,
            let opinions = cell.selectOpinions {
            
            cell.selectedItemLabel.text = opinions[selectedIndex]
            
        }
        else {
            
            cell.selectedItemLabel.text = ""
            
        }
        
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
    
    func presentSingleSelectViewController(_ tableView: UITableView, indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? SingleSelectCell {
            
            guard let opinions = cell.selectOpinions else { return }
            
            let segueSender = (cell.selectedIndex, opinions, indexPath)
            
            self.performSegue(withIdentifier: "singleSelectViewSegue", sender: segueSender)

        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let viewController = segue.destination as? SingleSelectViewController,
            let segueSender = sender as? (Int?, [String], IndexPath),
            segue.identifier == "singleSelectViewSegue" {
            
            viewController.delegate = self
            
            viewController.selectedIndex = segueSender.0
            
            viewController.opinions = segueSender.1
            
            viewController.originalIndexPath = segueSender.2
            
        }
        
    }
    
}

extension GvExpandTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        switch indexPath.row {
        case 0,1:
            return self.getDatePickerCell(tableView, indexPath: indexPath)
            
        case 2,3:
            return self.getSingleSelectCell(tableView, indexPath: indexPath)
            
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
        else {
            
            return 44.0
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        self.expandCollapseAnimate(tableView, indexPath: indexPath)
        
        switch indexPath.row {
        case 2,3:
            self.presentSingleSelectViewController(tableView, indexPath: indexPath)
            
        default:
            break
        }
        
    }
    
}

extension GvExpandTableViewController: SingleSelectProtocol {
    
    func didSelect(index: Int?, opinionName: String?, forOriginl indexPath: IndexPath) {
        
        guard let cell = self.GvExpandTableView.cellForRow(at: indexPath) as? SingleSelectCell else { return }
        
        cell.selectedIndex = index
        
        cell.selectedItemLabel.text = opinionName
        
        self.GvExpandTableView.reloadData()
        
    }
    
}
