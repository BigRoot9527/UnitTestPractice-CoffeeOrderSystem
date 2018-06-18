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
import CodableFirebase

struct COSDataManager {
    
    func getSelectionList(getArray: @escaping ([CoffeeItem]) -> Void) {
        
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
    
    func save() {
        let items = [AllOrdersInOneItem(itemName: "Green Tea", orders: [OrderType(cups: 3, iced: true, addsugar: false)])]
        let orders = OrderList(radomNum: 666666, account: "33456478", status: 1, time: Date.timeIntervalBetween1970AndReferenceDate, content: items, itemCount: 12, price: 500)
        let data = try? FirebaseEncoder().encode(orders)
        Database.database().reference().child("orders").childByAutoId().setValue(data)
    }
    
    func getOrderLists(getArray: @escaping ([OrderList]) -> Void) {
        
        var lists: [OrderList] = []
        
        Database.database().reference().child("orders").observeSingleEvent(of: .value) { snapshot in

            print(snapshot.value)
            guard let valueArray = snapshot.value as? [String: Any] else { return }
            
            valueArray.forEach{ value in
                guard let orders = try? FirebaseDecoder().decode(OrderList.self, from: value.value) else { return
                }
                print(orders)
                lists.append(orders)
            }
            
            DispatchQueue.main.async {
                getArray(lists)
            }
        }
    }
    
    
    
    
}
