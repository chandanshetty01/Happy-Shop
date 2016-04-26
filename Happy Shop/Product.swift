//
//  Product.swift
//  Happy Shop
//
//  Created by Chandan Shetty SP on 24/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

import Foundation

public struct Product {
    let id: String
    let name: String
    let category: String
    let price: Float64
    let imageURL: String
    let description: String?
    let underSale: Bool
    
    init?(id:String,name:String,category:String,price:Float64,imageURL:String,description:String,underSale:Bool){
        self.id = id
        self.name = name
        self.price = price
        self.imageURL = imageURL
        self.description = description
        self.underSale = underSale
        self.category = category
    }
    
    init?(dictionary:NSDictionary) {
        
        if let id = dictionary["id"] {
            self.id = String(id as! NSNumber)
        }
        else{
            return nil;
        }
        
        if let name = dictionary["name"] {
            self.name = name as! String
        }
        else{
            return nil;
        }
        
        if let category = dictionary["category"] {
            self.category = category as! String
        }
        else{
            return nil;
        }
        
        if let price = dictionary["price"]{
            self.price = Float64(price as! NSNumber)
        }
        else{
            self.price = 0.0
        }
        
        if let img_url = dictionary["img_url"] {
            self.imageURL = img_url as! String
        }
        else{
            return nil;
        }
        
        if let description = dictionary["description"] {
            self.description = description as? String
        }
        else{
            self.description = nil;
        }
        
        if let under_sale = dictionary["under_sale"]{
            self.underSale = Bool(under_sale as! NSNumber)
        }
        else{
            self.underSale = false
        }
    }
}