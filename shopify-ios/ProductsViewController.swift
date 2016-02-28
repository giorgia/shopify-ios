//
//  ProductsViewController.swift
//  shopify-ios
//
//  Created by Giorgia Marenda on 2/27/16.
//  Copyright © 2016 Giorgia Marenda. All rights reserved.
//

import Buy
import UIKit

class ProductsViewController: UIViewController {
    
    var products = [BUYProduct]()
    var currentPage: UInt = 1
    var reachedEnd = false
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchProducts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func fetchProducts() {
        Shopify.client?.getProductsPage(currentPage) { (products, page, reachedEnd, error) -> Void in
            self.currentPage = page
            self.reachedEnd = reachedEnd
            
            guard let buyProducts = products as? [BUYProduct] else { return }
            self.products.appendContentsOf(buyProducts)
        }
    }
}

