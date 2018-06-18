//
//  COSDataProvider.swift
//  UnitTestPracticeCoffeeOrderSystem
//
//  Created by 許庭瑋 on 2018/6/18.
//  Copyright © 2018年 許庭瑋. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct COSDataManager {
    
    func getSelectionList(getArray: @escaping ([CoffeeItem]) -> Void){
        
        var selections: [CoffeeItem] = []
        
        Database.database().reference().child("items").observeSingleEvent(of: .value) { snapshot in
            
            guard let item = snapshot.value as? [Any] else { return }
            
            item.forEach{ value in

                guard let array = value as? [String: Any] else { return }
                let url = array["image"] as? String ?? ""
                let name = array["name"] as? String ?? ""
                let price = array["price"] as? Int ?? 0
                let newCoffee = CoffeeItem(image: url, name: name, price: price)
                
                selections.append(newCoffee)
            }
            DispatchQueue.main.async {
                getArray(selections)
            }
        }
    }
}
