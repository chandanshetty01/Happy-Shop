//
//  FirstViewController.swift
//  Happy Shop
//
//  Created by Chandan Shetty SP on 24/4/16.
//  Copyright © 2016 Chandan Shetty SP. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class CategoriesViewController : UIViewController,UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    private let categoryFactory = CategoryFactory()
    var categories: [Category] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories();
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CategoriesViewController.handleCartDidModifiedNotification(_:)), name:CartNotifications.cartDidModifiedNotification, object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func loadCategories(){
        
        showLoadingHUD()
        
        Alamofire.request(.GET, "http://sephora-mobile-takehome-2.herokuapp.com/api/v1/categories.json", parameters: nil)
            .responseJSON { response in
                
                self.hideLoadingHUD()
                
                if let value = response.result.value as? NSDictionary {
                    let categoryArray:NSArray = value["categories"] as! NSArray
                    self.categories = self.categoryFactory.categoriesFromDictionaryArray(categoryArray)
                    self.tableView.reloadData()
                }
        }
    }
    
    private func showLoadingHUD() {
        MBProgressHUD.showHUDAddedTo(self.tableView, animated: true)
    }
    
    private func hideLoadingHUD() {
        MBProgressHUD.hideAllHUDsForView(self.tableView, animated: true)
    }
    
    // MARK: TableViewDelegates
    
    internal func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    internal func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Categories"
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell_identifier", forIndexPath: indexPath)
        
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    //MARK: Seque
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "products_seque_identifier") {
            //get a reference to the destination view controller
            let destinationVC:ProductsViewController = segue.destinationViewController as! ProductsViewController
            
            //set properties on the destination view controller
            destinationVC.category = sender.textLabel!!.text
        }
    }
    
    //MARK: Nofications
    
    func handleCartDidModifiedNotification(notification: NSNotification){
        self.tabBarController?.tabBar.items![1].badgeValue = String(CartManager.sharedInstance.totalProducts())
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

