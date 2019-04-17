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
        
        self.initGvTableView()
        
    }
    
    func initGvTableView() {
        
        self.GvExpandTableView.dataSource = self
        
        self.GvExpandTableView.delegate = self
        
    }

}

extension GvExpandTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandCell") as! GvExpandCell
        
        return cell
        
    }
    
}

extension GvExpandTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if let cell = tableView.cellForRow(at: indexPath) as? GvExpandCell {
            
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
        
        tableView.beginUpdates()
        
        guard let visibleIndexPaths = tableView.indexPathsForVisibleRows else {  tableView.endUpdates(); return }
        
        for visibleIndexPath in visibleIndexPaths {
            
            if let cell = tableView.cellForRow(at: visibleIndexPath) as? GvExpandCell {
                
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
