//
//  ProductsViewController.swift
//  shopify-ios
//
//  Created by Giorgia Marenda on 2/27/16.
//  Copyright © 2016 Giorgia Marenda. All rights reserved.
//

import Buy
import UIKit
import SnapKit

class ProductsViewController: UIViewController {
    
    var products = [BUYProduct]()
    var currentPage: UInt = 1
    var reachedEnd = false
    
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchProducts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupViews() {
        let layout = UICollectionViewFlowLayout()
        setupFlowLayout(layout)
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.registerClass(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseCellIdentifier)
        collectionView?.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(collectionView!)
        
        setupConstaints()
    }
    
    func setupFlowLayout(flowLayout: UICollectionViewFlowLayout) {
        let dim = view.frame.size.width < 415 ? view.frame.size.width : (view.frame.size.width - 2) / 2
        flowLayout.itemSize = CGSize(width: dim, height: dim)
        flowLayout.scrollDirection = .Vertical
        flowLayout.sectionInset = UIEdgeInsetsZero
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 1
        flowLayout.invalidateLayout()
    }
    
    func setupConstaints() {
        collectionView?.snp_makeConstraints { (make) -> Void in
           make.edges.equalTo(view)
        }
    }
    
    func fetchProducts() {
        Shopify.client?.getProductsPage(currentPage) { (products, page, reachedEnd, error) -> Void in
            self.currentPage = page
            self.reachedEnd = reachedEnd
            
            guard let buyProducts = products as? [BUYProduct] else { return }
            self.products.appendContentsOf(buyProducts)
            self.collectionView?.reloadData()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        setupFlowLayout(flowLayout)
    }
}

extension ProductsViewController: UICollectionViewDataSource {
   
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ProductCell.reuseCellIdentifier, forIndexPath: indexPath) as? ProductCell
        let product = products[indexPath.row]
        cell?.titleLabel.text = product.title
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == products.count - 1 {
            currentPage++
            fetchProducts()
        }
    }
   }

extension ProductsViewController: UICollectionViewDelegate {
    
    func productViewController() -> BUYProductViewController {
        let theme       = BUYTheme()
        theme.style     = .Light
        theme.tintColor = UIColor(red: 124.0/255.0, green: 162.0/255.0, blue: 142.0/255.0, alpha:1.0)
        theme.showsProductImageBackground = false
        
        let productDetailController = BUYProductViewController(client: Shopify.client, theme: theme)
        
        return productDetailController
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let product     = products[indexPath.row]
        let controller  = productViewController()
        controller.loadWithProduct(product) { (success, error) -> Void in
            controller.presentPortraitInViewController(self)
        }
    }
}
