//
//  ProductDetailViewController.swift
//  Happy Shop
//
//  Created by Chandan Shetty SP on 24/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import MBProgressHUD

class ProductDetailViewController : UIViewController{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var saleLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var productDescription: UITextView!
    
    var product:Product?

    override func viewDidLoad() {
        self.addToCartButton.layer.cornerRadius = 5

        updateUI()
        loadProduct()
    }
    
    func updateUI(){
        self.productNameLabel.text = product!.name
        self.productDescription.text = product!.description

        let price = product!.price
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        self.priceLabel.text = formatter.stringFromNumber(price)
        
        if product!.underSale{
            self.saleLabel.hidden = false
        }
        else{
            self.saleLabel.hidden = true
        }
        
        let placeholderImage = UIImage(named: "placeholder")!
        let URL = NSURL(string: self.product!.imageURL)!
        imageView.af_setImageWithURL(URL, placeholderImage: placeholderImage)
        
        self.title = product!.name
    }
    
    func loadProduct(){
        showLoadingHUD()
        
        let urlString = "http://sephora-mobile-takehome-2.herokuapp.com/api/v1/products/\(self.product!.id).json"
        Alamofire.request(.GET,urlString, parameters: nil)
            .responseJSON { response in
                
                self.hideLoadingHUD()
                
                if let value = response.result.value as? NSDictionary {
                    let productDictionary:NSDictionary = value["product"] as! NSDictionary
                    
                    if let product = Product(dictionary:productDictionary) {
                        self.product = product
                        self.updateUI()
                    }
                }
        }
    }

    private func showLoadingHUD() {
         MBProgressHUD.showHUDAddedTo(self.view, animated: true)
    }
    
    private func hideLoadingHUD() {
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
    }

    @IBAction func addToCartButtonAction(sender: AnyObject) {
    }
}