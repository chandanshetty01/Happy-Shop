//
//  ProductFactory.swift
//  Happy Shop
//
//  Created by Chandan Shetty SP on 24/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

import Foundation

class ProductFactory {
    
    //This method will create the array of Product objects
    func productsFromDictionaryArray(array:NSArray) -> [Product] {
        var products: [Product] = []
        for dictionary in array {
            if let product = Product(dictionary:dictionary as! NSDictionary) {
                products.append(product)
            }
        }
        return products
    }
}