//
//  SingleSelectViewController.swift
//  expandTableView
//
//  Created by ShaoJen Chen on 2019/4/18.
//  Copyright © 2019 ShaoJenChen. All rights reserved.
//

import UIKit

class SingleSelectViewController: UIViewController {

    var selectedIndex: Int?
    
    var opinions: [String]!
    
    var delegate: SingleSelectProtocol?
    
    @IBOutlet var tableBackView: UIView!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var tableBackViewConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addBlurBackGroundView()
        
        self.setTableBackView()
        
    }
    
    func setTableBackView() {
        
        self.tableView.tableFooterView = UIView()

        let maxHeight = self.view.frame.height * 0.65
        
        let estimateHeight = CGFloat(self.opinions.count) * 44 + 10
        
        let heightConstant = estimateHeight > maxHeight ? maxHeight : estimateHeight
        
        self.tableBackViewConstraint.constant = heightConstant
        
        self.view.bringSubviewToFront(tableBackView)
    }
    
    func addBlurBackGroundView() {
        
        let effect = UIBlurEffect(style: .light)
        
        let visualEffectView = UIVisualEffectView(frame: self.view.frame)
        
        visualEffectView.effect = effect
        
        visualEffectView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        
        visualEffectView.addGestureRecognizer(tapGesture)
        
        self.view.addSubview(visualEffectView)
        
    }

    @objc func tap(_ sender: UITapGestureRecognizer) {
        
        self.selectedIndex = nil

        tableView.reloadData()

        self.delegate?.didSelect(index: nil)
        
        self.dismiss(animated: true, completion: nil)
        
    }
}

extension SingleSelectViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.opinions.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "OpinionCell") as? OpinionCell {
            
            cell.opinionLabel.text = self.opinions[indexPath.row]
            
            guard indexPath.row == self.selectedIndex else { cell.accessoryType = .none; return cell }
            
            cell.accessoryType = .checkmark
            
            return cell
        }

        return UITableViewCell()
    }
    
}

extension SingleSelectViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedIndex = indexPath.row
        
        tableView.reloadData()
        
        
        self.delegate?.didSelect(index: indexPath.row)
        
        DispatchQueue.main.async {
        
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
}
