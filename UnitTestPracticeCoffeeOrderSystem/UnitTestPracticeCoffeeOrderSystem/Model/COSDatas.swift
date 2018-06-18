//
//  COSDatas.swift
//  UnitTestPracticeCoffeeOrderSystem
//
//  Created by 許庭瑋 on 2018/6/18.
//  Copyright © 2018年 許庭瑋. All rights reserved.
//

import Foundation


struct CoffeeItem: Codable {
    
    let image: String
    let name: String
    let price: Int
}

struct OrderItem {
    
    let coffeType: CoffeeItem
    var iced: Bool
    var addSugar: Bool
}
