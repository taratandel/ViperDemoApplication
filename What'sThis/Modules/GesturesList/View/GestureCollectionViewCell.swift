//
//  GestureCollectionViewCell.swift
//  What'sThis
//
//  Created by Tara Tandel on 20/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import UIKit
import SDWebImage

class GestureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var gestureImage: UIImageView!
    @IBOutlet weak var gestureName: UILabel!
    @IBOutlet weak var imageLoader: UIActivityIndicatorView!
    
    override var isSelected: Bool {
        didSet {
            gestureImage.layer.borderWidth = isSelected ? 10 : 2
            gestureImage.layer.borderColor = isSelected ? UIColor.red.cgColor : UIColor.blue.cgColor

        }
    }
    
    override func awakeFromNib() {
        isSelected = false
        super.awakeFromNib()
    }
    
    func fillData (_ gesture: Gestures) {
        imageLoader.startAnimating()
        self.gestureImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.gestureImage.sd_setImage(with: URL(string: gesture.thumbNailImageURL), placeholderImage: UIImage(named: "g1"), options: .progressiveLoad, completed: {
            [weak self]  (_,_,_,_) in
            self?.imageLoader.isHidden = true
        })
        self.gestureImage.backgroundColor = .red
        self.gestureName.text = gesture.name
        self.gestureName.backgroundColor = .darkGray
        self.gestureName.textColor = .white
        self.backgroundColor = .black
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutIfNeeded()
        let layoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutAttributes.bounds.size = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
        return layoutAttributes
    }

}
