//
//  CategoryFactory.swift
//  Happy Shop
//
//  Created by Chandan Shetty SP on 24/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

import Foundation

class CategoryFactory {
    
    //This method will create the array of Category objects
    func categoriesFromDictionaryArray(array:NSArray) -> [Category] {
        var Categories: [Category] = []
        for dictionary in array {
            if let flavor = Category(dictionary:dictionary as! NSDictionary) {
                Categories.append(flavor)
            }
        }
        return Categories
    }
}

