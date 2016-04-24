//
//  Category.swift
//  Happy Shop
//
//  Created by Chandan Shetty SP on 24/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

import Foundation

struct Category {
    let name: String
    let productsCount: Int
    
    init?(dictionary:NSDictionary) {
        
        if let name = dictionary["name"] {
            self.name = name as! String
        }
        else{
            return nil;
        }
        
        if let prodCount = dictionary["products_count"]{
            self.productsCount = Int(prodCount as! NSNumber)
        }
        else{
            self.productsCount = 0
        }
    }
}