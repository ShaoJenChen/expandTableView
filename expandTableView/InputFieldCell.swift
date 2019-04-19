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
    
    @IBOutlet var cellHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var textView: UITextView!
    
    var tableView: UITableView?
    
    var placeHolder: String? {
        
        willSet {
            
            if let placeholder = newValue {
                
                self.textView.text = placeholder
                
                self.textView.textColor = .gray
                
            }
            
        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

extension InputFieldCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        self.tableView?.beginUpdates()
        
        let constant = textView.contentSize.height > 43.5 ? textView.contentSize.height : 43.5
        
        self.cellHeightConstraint.constant = constant

        self.tableView?.endUpdates()
    
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        self.textView.text = nil
        
        self.textViewDidChange(textView)
        
        if self.textView.textColor == .gray {
            
            self.textView.textColor = .white
            
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if self.textView.text.isEmpty {
            
            self.textView.text = self.placeHolder
            
            self.textView.textColor = .gray
            
        }
        
        textView.scrollRectToVisible(CGRect.zero, animated: false)
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            
            textView.endEditing(true)
            
            return false
        }
        
        return true
    }
    
}
