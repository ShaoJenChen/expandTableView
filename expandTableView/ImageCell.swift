//
//  ImageCell.swift
//  expandTableView
//
//  Created by 陳劭任 on 2019/5/1.
//  Copyright © 2019 ShaoJenChen. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.layer.borderColor = UIColor.black.cgColor
        
        self.layer.borderWidth = 1
        
        self.layer.cornerRadius = self.frame.width / 10
        
        self.layer.masksToBounds = true
        
    }
    
}
