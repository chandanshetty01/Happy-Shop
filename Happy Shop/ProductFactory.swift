//
//  ProductFactory.swift
//  Happy Shop
//
//  Created by Chandan Shetty SP on 24/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

import Foundation

class ProductFactory {
    
    func productsFromDictionaryArray(array:NSArray) -> [Product] {
        var products: [Product] = []
        for dictionary in array {
            if let flavor = Product(dictionary:dictionary as! NSDictionary) {
                products.append(flavor)
            }
        }
        return products
    }
}