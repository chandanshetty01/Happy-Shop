//
//  ProductsViewController.swift
//  Happy Shop
//
//  Created by Chandan Shetty SP on 24/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ProductsViewController : UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    private let productFactory = ProductFactory()
    var products: [Product] = []
    
    var category:String? {
        didSet {
            loadProducts()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadProducts(){
        self.navigationController?.title = self.category

        Alamofire.request(.GET, "http://sephora-mobile-takehome-2.herokuapp.com/api/v1/products.json", parameters: ["category": self.category!])
            .responseJSON { response in
                
                self.hideLoadingHUD()
                
                if let value = response.result.value as? NSDictionary {
                    let productsArray:NSArray = value["products"] as! NSArray
                    self.products = self.productFactory.productsFromDictionaryArray(productsArray)
                    self.collectionView!.reloadData()
                }
        }
    }
    
    private func showLoadingHUD() {
        
    }
    
    private func hideLoadingHUD() {
        
    }

    //MARK : Collection View delegates
    internal func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    internal func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }
    
    //3
    internal func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("product_cell_identifier", forIndexPath: indexPath) as! ProductCollectionViewCell
        let product = products[indexPath.row]

        // Configure the cell
        cell.product = product

        return cell
    }
}