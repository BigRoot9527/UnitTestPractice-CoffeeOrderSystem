//
//  CollectionViewCell.swift
//  UnitTestPracticeCoffeeOrderSystem
//
//  Created by 許庭瑋 on 2018/6/18.
//  Copyright © 2018年 許庭瑋. All rights reserved.
//

import UIKit
import SDWebImage

class SelectionCollectionViewCell: UICollectionViewCell {
    
    var imageUrl: String = "" {
        
        didSet {
            loadImage()
        }
    }
    
    @IBOutlet weak var selectionImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    private func loadImage() {
        
        selectionImageView.sd_setImage(with: URL(string: imageUrl), completed: nil)
    }
}
