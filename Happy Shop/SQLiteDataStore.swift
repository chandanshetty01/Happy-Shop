//
//  SQLiteDataStore.swift
//  Happy Shop
//
//  Created by Chandan Shetty SP on 26/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

import Foundation
import SQLite

class SQLiteDataStore {
    static let sharedInstance = SQLiteDataStore()
    
    let db:Connection
    let users = Table("cart")
    
    let id = Expression<String>("id")
    let name = Expression<String?>("name")
    let category = Expression<String>("category")
    let price = Expression<Float64>("price")
    let imageURL = Expression<String>("imageURL")
    let description = Expression<String>("description")
    let underSale = Expression<Bool>("underSale")
    let quantity = Expression<Int>("quantity")
    
    private init() {
        
        let path = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory, .UserDomainMask, true
            ).first!
        
        db = try! Connection("\(path)/happyShop.sqlite3")
        


        try! db.run(users.create(ifNotExists:true) { t in
            t.column(id, primaryKey: true)
            t.column(name)
            t.column(category)
            t.column(price)
            t.column(imageURL)
            t.column(description)
            t.column(underSale)
            t.column(quantity)
            })
    }
    
     func insert(cartItem:CartItem){
        
        let insert = users.insert(id <- cartItem.product.id,
                                  name <- cartItem.product.name,
                                  category <- cartItem.product.category,
                                  price <- Float64(cartItem.product.price),
                                  imageURL <- cartItem.product.imageURL,
                                  description <- cartItem.product.description!,
                                  underSale <- cartItem.product.underSale,
                                  quantity <- cartItem.quantity)
        try! db.run(insert)
        
        }

    func loadCartItems(){
        for user in try! db.prepare(users) {
            print("id: \(user[id]), name: \(user[name]), email: \(user[category])")
            // id: 1, name: Optional("Alice"), email: alice@mac.com
        }
    }
}