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
        
        let cart =  users.filter(id == cartItem.product.id)
        let count =  db.scalar(cart.count)
        if count == 0{
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
        else{
            let query = users.select(quantity)
                .filter(id == cartItem.product.id)
            for user in try! db.prepare(query) {
               try! db.run(cart.update(quantity <- user[quantity]+1))
            }
        }
    }
    
    func remove(inId:String) -> Int {
        let row = users.filter(id == inId)
        let status = try! db.run(row.delete())
        return status
    }
    
    func totalAmout() -> Float64{
        var amount:Float64 = 0
        
        for cartItem in try! db.prepare(users) {
            amount =  amount + cartItem[price]*Float64(cartItem[quantity])
        }        
        return amount
    }
    
    func totalProducts() -> Int{
        let count = db.scalar(users.count)
        return count
    }
    
    func clear() -> Int {
        let status = try! db.run(users.delete())
        return status
    }

    func getAllCartItems() -> [CartItem]{
        var cartItems:[CartItem] = []

        for cartItem in try! db.prepare(users) {
            let product:Product = Product(id: cartItem[id], name: cartItem[name]!, category: cartItem[category], price: cartItem[price], imageURL: cartItem[imageURL], description: cartItem[description], underSale: cartItem[underSale])!
            let cartItem:CartItem = CartItem(product:product,quantity:cartItem[quantity])
            cartItems.append(cartItem)
        }
        
        return cartItems
    }
}