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
    
    private var cartItems:[CartItem] = []
    
    init(){
        SQLiteDataStore.sharedInstance.loadCartItems()
    }
    
    // MARK: - Public Methods
    
    public func totalAmout() -> Float{
        var amount:Float = 0
        
        for cartItem:CartItem in cartItems {
            amount =  amount + cartItem.product.price*Float(cartItem.quantity)
        }
        
        return amount
    }
    
    public func totalProducts() -> Int{
        return cartItems.count
    }
    
    public func clear(){
        cartItems.removeAll()
    }
    
    public func addProduct(product:Product,quantity:Int) -> Void{
        let cartItem:CartItem = CartItem(product: product,quantity: quantity)
        cartItems.append(cartItem)
        
        SQLiteDataStore.sharedInstance.insert(cartItem)
        NSNotificationCenter.defaultCenter().postNotificationName(CartNotifications.cartDidModifiedNotification, object: nil)
    }
    
    public func cartItemAtIndex(index:Int) -> CartItem {
        return cartItems[index]
    }
}
