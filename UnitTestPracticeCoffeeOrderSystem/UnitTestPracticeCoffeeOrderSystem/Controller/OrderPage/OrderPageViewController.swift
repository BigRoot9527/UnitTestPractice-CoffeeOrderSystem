//
//  OrderPageViewController.swift
//  UnitTestPracticeCoffeeOrderSystem
//
//  Created by 許庭瑋 on 2018/6/18.
//  Copyright © 2018年 許庭瑋. All rights reserved.
//
import UIKit
import Firebase

class OrderPageViewController: UIViewController {
    
    private var selectionVC: SelectionViewController?
    private var itemListVC: ItemListViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildVC()
    }
    
    private func setupChildVC() {
        
        guard let selectionVC = selectionVC, let itemListVC = itemListVC else { return }
        
        selectionVC.delegate = self
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
            
        case let SelectionViewController as SelectionViewController:
            self .selectionVC = SelectionViewController
        
        case let ItemListViewController as ItemListViewController:
            self .itemListVC = ItemListViewController
        
        default:
            break

        }
    }
}

extension OrderPageViewController: SelectionViewControllerDelegate {
    
    func itemSelected(sender: UIViewController, item: CoffeeItem) {
        itemListVC?.newCoffeeItem = item
    }
}
