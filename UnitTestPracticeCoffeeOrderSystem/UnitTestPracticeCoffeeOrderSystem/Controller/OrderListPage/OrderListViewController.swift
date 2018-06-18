//
//  OrderListViewController.swift
//  UnitTestPracticeCoffeeOrderSystem
//
//  Created by 許庭瑋 on 2018/6/18.
//  Copyright © 2018年 許庭瑋. All rights reserved.
//

import UIKit

class OrderListViewController: UIViewController {

    @IBOutlet weak var orderListTableView: UITableView!
    
    let manager = COSDataManager()
    var listArray: [OrderList] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadData()
        
        setupTableView()
    }
    
    private func loadData() {
        manager.getOrderLists { [weak self] lists in
            
            self?.listArray = lists
            self?.orderListTableView.reloadData()
        }
    }
    
    private func setupTableView() {
        let topIdent = String(describing: OrderListTableviewTopCell.self)
        let topNib = UINib(nibName: topIdent, bundle: nil)
        let bottomIdent = String(describing: OrderListTableviewBottomCell.self)
        let bottomNib = UINib(nibName: bottomIdent, bundle: nil)
        orderListTableView.register(topNib, forCellReuseIdentifier: topIdent)
        orderListTableView.register(bottomNib, forCellReuseIdentifier: bottomIdent)
        
        orderListTableView.delegate = self
        orderListTableView.dataSource = self
    }
}

extension OrderListViewController: UITableViewDelegate {
    
    
}

extension OrderListViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count * 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return indexPath.row % 2 == 1 ?  45.0 : 125.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row % 2 == 0 {
            
            guard let cell = orderListTableView.dequeueReusableCell(withIdentifier: String(describing: OrderListTableviewTopCell.self), for: indexPath) as? OrderListTableviewTopCell else { return UITableViewCell() }
            
            cell.orderAccountLabel.text = listArray[indexPath.row/2].account
            
            cell.orderNumLabel.text = String(listArray[indexPath.row/2].radomNum)
            
            cell.orderStatusLabel.text = String(listArray[indexPath.row/2].status)
            
            cell.orderTimeLabel.text = String(listArray[indexPath.row/2].time)
            
            return cell
        } else {
            guard let cell = orderListTableView.dequeueReusableCell(withIdentifier: String(describing: OrderListTableviewBottomCell.self), for: indexPath) as? OrderListTableviewBottomCell else { return UITableViewCell() }
            
            cell.totalItemCountLabel.text = String(listArray[(indexPath.row - 1)/2 ].itemCount)
            
            cell.totalItemPriceLabel.text = String(listArray[(indexPath.row - 1)/2 ].price)
            
            return cell
        }

    }

}
