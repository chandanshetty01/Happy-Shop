//
//  CartManager.swift
//  Happy Shop
//
//  Created by Chandan Shetty SP on 25/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

import Foundation

struct CartNotifications {
    static let cartDidModifiedNotification = "cartDidModifiedNotification"
}

public class CartManager {
    
    static let sharedInstance = CartManager()
    // MARK: - private Properties
    
    init(){
    }
    
    // MARK: - Public Methods
    
    public func totalAmout() -> Float64{
       return SQLiteDataStore.sharedInstance.totalAmout()
    }
    
    public func totalProducts() -> Int{
        return SQLiteDataStore.sharedInstance.totalProducts()
    }
    
    public func clear() -> Int{
        NSNotificationCenter.defaultCenter().postNotificationName(CartNotifications.cartDidModifiedNotification, object: nil)

        return SQLiteDataStore.sharedInstance.clear()
    }
    
    public func addProduct(product:Product,quantity:Int) -> Void{
        SQLiteDataStore.sharedInstance.insert(CartItem(product: product,quantity: quantity))
        NSNotificationCenter.defaultCenter().postNotificationName(CartNotifications.cartDidModifiedNotification, object: nil)
    }
    
    public func removeProduct(id:String) -> Int{
        let status = SQLiteDataStore.sharedInstance.remove(id)
        NSNotificationCenter.defaultCenter().postNotificationName(CartNotifications.cartDidModifiedNotification, object: nil)
        return status
    }
    
    public func allCartItems() -> [CartItem] {
        return SQLiteDataStore.sharedInstance.getAllCartItems()
    }
}
