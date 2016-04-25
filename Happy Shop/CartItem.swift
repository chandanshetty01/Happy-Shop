//
//  CartItem.swift
//  Happy Shop
//
//  Created by Chandan Shetty SP on 25/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

import Foundation

public struct CartItem {
    let product : Product
    let quantity : Int
    
    init(product:Product){
        self.product = product
        self.quantity = 1
    }
    
    init(product:Product,quantity:Int){
        self.product = product
        self.quantity = quantity
    }
}