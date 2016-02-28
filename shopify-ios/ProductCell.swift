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
    var imageView: UIImageView!
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    func setupViews() {
        imageView = UIImageView(frame: frame)
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        addSubview(titleLabel)
        addSubview(originalPriceLabel)
        addSubview(salePriceLabel)
        addSubview(imageView)
        
        setupConstraints()
    }
    
    func constraintView(view: UIView, below belowView: UIView) {
        view.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(belowView.snp_bottom).offset(5)
            make.left.equalTo(snp_left).offset(10)
            make.right.equalTo(snp_right).offset(10)
        }
    }
    
    func setupConstraints() {
        imageView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(snp_top)
            make.height.equalTo(frame.height * 0.8)
            make.left.equalTo(snp_left)
            make.right.equalTo(snp_right)
        }
        constraintView(titleLabel, below: imageView)
        constraintView(originalPriceLabel, below: titleLabel)
        constraintView(salePriceLabel, below: originalPriceLabel)
    }
    
    override func preferredLayoutAttributesFittingAttributes(layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        if let attributes = layoutAttributes.copy() as? UICollectionViewLayoutAttributes {
            var newFrame = attributes.frame
            frame = attributes.frame
            
            setNeedsLayout()
            layoutIfNeeded()
            
            let desiredHeight: CGFloat = self.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
            newFrame.size.height = desiredHeight
            attributes.frame = newFrame
            return attributes
        }
        return layoutAttributes
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
