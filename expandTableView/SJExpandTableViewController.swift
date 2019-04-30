//
//  SJExpandTableViewController.swift
//  ExpandTableView
//
//  Created by 陳劭任 on 2019/4/16.
//  Copyright © 2019 陳劭任. All rights reserved.
//

import UIKit

class SJExpandTableViewController: UIViewController, SJExpandProtocol {
    
    @IBOutlet weak var SJExpandTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.extendedLayoutIncludesOpaqueBars = true
        
        self.SJExpandTableView.tableFooterView = UIView()
        
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
        
        return self.getExpandCellHeight(tableView, indexPath: indexPath)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.expandCollapseAnimate(tableView, indexPath: indexPath)
        
    }
    
}
