//
//  SelectionViewController.swift
//  UnitTestPracticeCoffeeOrderSystem
//
//  Created by 許庭瑋 on 2018/6/18.
//  Copyright © 2018年 許庭瑋. All rights reserved.
//

import UIKit

protocol SelectionViewControllerDelegate: class {
    
    func itemSelected(sender: UIViewController, item: CoffeeItem) -> Void
}

class SelectionViewController: UIViewController {

    
    @IBOutlet weak var selectionCollectionview: UICollectionView!
    
    let manager = COSDataManager()
    var selections: [CoffeeItem] = []
    weak var delegate: SelectionViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadData()
        setupCollectionView()
        
    }
    
    private func loadData() {
        
        manager.getSelectionList { [weak self] array in
            self?.selections = array
            self?.selectionCollectionview.reloadData()
        }
    }
    
    private func setupCollectionView() {
        
        selectionCollectionview.dataSource = self
        selectionCollectionview.delegate = self
        
        let identifier = String(describing: SelectionCollectionViewCell.self)
        let xib = UINib(nibName: identifier, bundle: nil)
        selectionCollectionview.register(xib, forCellWithReuseIdentifier: identifier)
    }
}


extension SelectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return selections.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = selectionCollectionview.dequeueReusableCell(
            withReuseIdentifier: String(describing: SelectionCollectionViewCell.self),
            for: indexPath)
        
        guard let selectionCell = cell as? SelectionCollectionViewCell else { return cell }
        
        selectionCell.imageUrl = selections[indexPath.row].image
        
        return selectionCell
    }
}

extension SelectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.itemSelected(sender: self, item: selections[indexPath.row])
    }
}
