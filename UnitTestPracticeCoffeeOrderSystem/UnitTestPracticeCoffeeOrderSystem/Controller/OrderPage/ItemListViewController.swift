//
//  ItemListViewController.swift
//  UnitTestPracticeCoffeeOrderSystem
//
//  Created by 許庭瑋 on 2018/6/18.
//  Copyright © 2018年 許庭瑋. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {

    
    @IBOutlet weak var itemListTableView: UITableView!
    
    //input
    var newCoffeeItem: CoffeeItem? {
        didSet {
            convertToOrderItem()
        }
    }
    
    private var orderArray: [OrderItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()

    }
    
    private func setupTableView() {
        
        let identifier = String(describing: ItemListTableViewCell.self)
        let xib = UINib(nibName: identifier, bundle: nil)
        itemListTableView.register(xib, forCellReuseIdentifier: identifier)
        itemListTableView.delegate = self
        itemListTableView.dataSource = self
    }
    
    private func convertToOrderItem() {
        
        guard let newItem = newCoffeeItem else { return }
        
        let newOrder = OrderItem(coffeType: newItem, iced: true, addSugar: true)
        
        orderArray.append(newOrder)
        
        itemListTableView.reloadData()
    }
}

extension ItemListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return orderArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = itemListTableView.dequeueReusableCell(withIdentifier: String(describing: ItemListTableViewCell.self), for: indexPath) as? ItemListTableViewCell else { return UITableViewCell() }
        
        let orderItem = orderArray[indexPath.row]
        
        cell.delegate = self
        cell.itemIceButton.isSelected = orderItem.iced
        cell.itemHotButton.isSelected = !orderItem.iced
        cell.itemAddSugarButton.isSelected = orderItem.addSugar
        cell.itemNoSugarButton.isSelected = !orderItem.addSugar
        cell.itemNameLabel.text = orderItem.coffeType.name
        cell.itemImageView.sd_setImage(with: URL(string: orderItem.coffeType.image), completed: nil)
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
}

extension ItemListViewController: UITableViewDelegate {
    
}

extension ItemListViewController: ItemListTableViewCellDelegate {
    
    func tempButtonsTapped(sender: UITableViewCell, isIced: Bool) {
        
        guard let index = itemListTableView.indexPath(for: sender) else { return }
        
        orderArray[index.row].iced = isIced
        
        itemListTableView.reloadData()
    }
    
    func sugarButtonsTapped(sender: UITableViewCell, addSugar: Bool) {
        
        guard let index = itemListTableView.indexPath(for: sender) else { return }
        
        orderArray[index.row].addSugar = addSugar
        
        itemListTableView.reloadData()
        
    }
}
