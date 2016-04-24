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
import MBProgressHUD

class ProductsViewController : UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    private let productFactory = ProductFactory()
    var products: [Product] = []
    var category:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.category

        loadProducts()
        self.navigationController?.navigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadProducts(){
        showLoadingHUD()
        
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
        MBProgressHUD.showHUDAddedTo(self.collectionView, animated: true)
    }
    
    private func hideLoadingHUD() {
        MBProgressHUD.hideAllHUDsForView(self.collectionView, animated: true)
    }

    //MARK : Collection View delegates
    internal func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    internal func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }
    
    internal func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("product_cell_identifier", forIndexPath: indexPath) as! ProductCollectionViewCell
        let product = products[indexPath.row]

        // Configure the cell
        cell.product = product

        return cell
    }
    
    //MARK: Seque
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "product_detail_seque_identifier") {
            //get a reference to the destination view controller
            let destinationVC:ProductDetailViewController = segue.destinationViewController as! ProductDetailViewController
            let productCell = sender as! ProductCollectionViewCell
            let product = productCell.product
            
            //set properties on the destination view controller
            destinationVC.product = product!
        }
    }
}