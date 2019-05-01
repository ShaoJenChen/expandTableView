//
//  MultiImageCell.swift
//  expandTableView
//
//  Created by 陳劭任 on 2019/5/1.
//  Copyright © 2019 ShaoJenChen. All rights reserved.
//

import UIKit

class MultiImageCell: BaseCell {

    var images: [UIImage]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

extension MultiImageCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else { return UICollectionViewCell() }
        
        if let images = self.images,
            0 ..< images.count ~= indexPath.row {
            
            imageCell.imageView.image = images[indexPath.row]
            
        }
        else {
            
            imageCell.imageView.image = UIImage(named: "plus")

        }
        
        return imageCell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let images = self.images else { return 1 }
        
        return images.count < 3 ? images.count + 1 : images.count

    }
    
}

extension MultiImageCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let images = self.images else {
            
            print("didSelect Plus Cell")
            
            return
            
        }
        
        if indexPath.row == images.count {
            
            print("didSelect Plus Cell")
            
        }
        else {
            
            print("didSelect image")
            
        }
        
    }

}
