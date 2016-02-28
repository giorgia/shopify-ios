//
//  Shopify.swift
//  shopify-ios
//
//  Created by Giorgia Marenda on 2/28/16.
//  Copyright © 2016 Giorgia Marenda. All rights reserved.
//

import Buy
import Keys
import Foundation

struct Shopify {
    
    static let keys = ShopifyiosKeys()
    static let cart = BUYCart()
    static let client = BUYClient(shopDomain: Shopify.keys.shopifyDomain(), apiKey: Shopify.keys.shopifyAPIKey(), channelId: Shopify.keys.shopifyChannelId())
    static var shop: BUYShop?
    
    static func configure() {
        Shopify.client?.getShop({ (shop, error) -> Void in
            Shopify.shop = shop
        })
    }
}