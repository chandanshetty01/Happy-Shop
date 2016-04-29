//
//  ProductsViewController.swift
//  Happy Shop
//
//  Created by Chandan Shetty SP on 24/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class ProductsViewController : UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,ProductDataSourceDelegats {

    @IBOutlet weak var collectionView: UICollectionView!
    var category:String?
    var productDatSource:ProductDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.category

        productDatSource = ProductDataSource(category:self.category!,delegate:self)
        
        productDatSource!.requestProducts()
        self.navigationController?.navigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Product datasource Delegates
    func productsDidLoaded(){
        self.collectionView.reloadData()
    }
    
    func productDidStartedLoading(){
        showLoadingHUD()
    }
    
    func productDidEndloading(){
        hideLoadingHUD()
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
        return productDatSource!.totalNumberOfProducts()
    }
    
    internal func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("product_cell_identifier", forIndexPath: indexPath) as! ProductCollectionViewCell
        
        let product = productDatSource!.productAtIndex(indexPath.row)

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