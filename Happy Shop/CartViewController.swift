//
//  SecondViewController.swift
//  Happy Shop
//
//  Created by Chandan Shetty SP on 24/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

import UIKit

class CartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var emptyCartLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.checkoutButton.layer.cornerRadius = 5.0
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        if CartManager.sharedInstance.totalProducts() == 0{
            self.emptyCartLabel.hidden = false
            self.tableView.hidden = true
            self.checkoutButton.hidden = true
            self.totalPriceLabel.hidden = true
        }
        else{
            self.emptyCartLabel.hidden = true
            self.tableView.hidden = false
            self.checkoutButton.hidden = false
            self.totalPriceLabel.hidden = false
            
            let price = CartManager.sharedInstance.totalAmout()
            
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .CurrencyStyle
            formatter.locale = NSLocale.currentLocale()
            self.totalPriceLabel.text = "Total Price: \(formatter.stringFromNumber(price)!)"

            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: TableViewDelegates
    
    internal func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartManager.sharedInstance.totalProducts()
    }
    
    internal func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cart Items"
    }
    
    @objc internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cartItem_cell_identifier", forIndexPath: indexPath) as! CartItemTableViewCell
        
        let cartItem = CartManager.sharedInstance.cartItemAtIndex(indexPath.row)
        cell.cartItem = cartItem
        
        return cell
    }
    
    //MARK: Button actions
    @IBAction func handleCheckOutButtonAction(sender: AnyObject) {
    }
}

