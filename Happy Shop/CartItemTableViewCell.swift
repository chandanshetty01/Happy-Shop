//
//  CartItemTableViewCell.swift
//  Happy Shop
//
//  Created by Chandan Shetty SP on 25/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

import Foundation
import UIKit

class CartItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var cartItem:CartItem?{
        didSet{

            self.name.text = cartItem?.product.name

            let price = cartItem?.product.price
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .CurrencyStyle
            formatter.locale = NSLocale.currentLocale()
            self.priceLabel.text = formatter.stringFromNumber(price!)
        }
    }
}