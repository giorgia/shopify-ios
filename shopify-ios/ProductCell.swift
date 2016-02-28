//
//  ProductCell.swift
//  shopify-ios
//
//  Created by Giorgia Marenda on 2/28/16.
//  Copyright © 2016 Giorgia Marenda. All rights reserved.
//

import UIKit
import SnapKit

class ProductCell: UICollectionViewCell {

    static let reuseCellIdentifier   = "productCellIdentifier"

    lazy var titleLabel = UILabel()
    lazy var originalPriceLabel = UILabel()
    lazy var salePriceLabel = UILabel()
    lazy var imageView = UIImageView()
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    func setupViews() {
        addSubview(titleLabel)
        addSubview(originalPriceLabel)
        addSubview(salePriceLabel)
        addSubview(imageView)
        
        setupConstraints()
    }
    
    func constraintView(view: UIView, below belowView: View) {
        view.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(belowView.snp_top)
            make.left.equalTo(snp_left)
            make.right.equalTo(snp_right)
        }
    }
    
    func setupConstraints() {
        constraintView(imageView, below: self)
        constraintView(titleLabel, below: imageView)
        constraintView(originalPriceLabel, below: titleLabel)
        constraintView(salePriceLabel, below: originalPriceLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
