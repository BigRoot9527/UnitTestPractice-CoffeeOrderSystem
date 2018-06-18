//
//  ItemListTableViewCell.swift
//  UnitTestPracticeCoffeeOrderSystem
//
//  Created by 許庭瑋 on 2018/6/18.
//  Copyright © 2018年 許庭瑋. All rights reserved.
//

import UIKit

protocol ItemListTableViewCellDelegate: class {
    
    func tempButtonsTapped(sender: UITableViewCell, isIced: Bool) -> Void
    func sugarButtonsTapped(sender: UITableViewCell, addSugar: Bool) -> Void
}

class ItemListTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemIceButton: UIButton!
    @IBOutlet weak var itemHotButton: UIButton!
    @IBOutlet weak var itemAddSugarButton: UIButton!
    @IBOutlet weak var itemNoSugarButton: UIButton!
    
    weak var delegate: ItemListTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func icedButtonTapped(_ sender: UIButton) {
//        sender.isSelected = true
//        itemHotButton.isSelected = false
        delegate?.tempButtonsTapped(sender: self, isIced: true)
    }
    
    @IBAction func hotButtonTapped(_ sender: UIButton) {
//        sender.isSelected = true
//        itemIceButton.isSelected = false
        delegate?.tempButtonsTapped(sender: self, isIced: false)
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
//        sender.isSelected = true
//        itemNoSugarButton.isSelected = false
        delegate?.sugarButtonsTapped(sender: self, addSugar: true)
    }
    @IBAction func noButtonTapped(_ sender: UIButton) {
//        sender.isSelected = true
//        itemAddSugarButton.isSelected = false
        delegate?.sugarButtonsTapped(sender: self, addSugar: false)
    }
}
