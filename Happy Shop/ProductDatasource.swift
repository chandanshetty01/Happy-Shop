//
//  ProductDatasource.swift
//  Happy Shop
//
//  Created by Chandan Shetty SP on 29/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

import Foundation
import Alamofire

public class ProductDataSource {
    var products: [Product] = []
    var category:String?
    weak public var delegate: ProductDataSourceDelegats?
    private let productFactory = ProductFactory()

    init(category:String,delegate:ProductDataSourceDelegats){
        self.category = category
        self.delegate = delegate
    }
    
    func requestProducts() -> Void {
        self.delegate!.productDidStartedLoading()

        Alamofire.request(.GET, "http://sephora-mobile-takehome-2.herokuapp.com/api/v1/products.json", parameters: ["category": self.category!])
            .responseJSON { response in
                
                self.delegate!.productDidEndloading()
                
                guard (response.result.value != nil) else{
                    return;
                }
                
                guard (response.result.error == nil) else{
                    return;
                }
                

                if let value = response.result.value as? NSDictionary {
                    let productsArray:NSArray = value["products"] as! NSArray
                    
                    self.products = self.productFactory.productsFromDictionaryArray(productsArray)

                    guard (self.products.count > 0) else{
                        return;
                    }
                    
                    self.delegate!.productsDidLoaded()
                }
        }
    }

    func totalNumberOfProducts() -> Int {
        return products.count
    }
    
    func productAtIndex(index:Int) -> Product {
        return products[index];
    }
}

public protocol ProductDataSourceDelegats:NSObjectProtocol {
    func productsDidLoaded()
    func productDidStartedLoading()
    func productDidEndloading()
}
