//
//  ProductCollectionViewCell.swift
//  Happy Shop
//
//  Created by Chandan Shetty SP on 24/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var saleLabel: UILabel!
    
    var product:Product? {
        didSet {
            
            self.productNameLabel.text = product!.name
            
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
        }
    }
}