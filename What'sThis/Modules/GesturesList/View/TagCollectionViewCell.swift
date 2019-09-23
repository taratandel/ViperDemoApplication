//
//  TagCollectionViewCell.swift
//  What'sThis
//
//  Created by Tara Tandel on 23/09/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import UIKit
protocol TagCollectionViewCellProtocol: class {
    func buttonClicked()
}
class TagCollectionViewCell: UICollectionViewCell {
    weak var delegate: TagCollectionViewCellProtocol?
    
    var details: String = ""
    var index: Int = -1
    
    var borderColor: UIColor? = .black
    var cellBackgroundColor: UIColor? = .white
    var textColor: UIColor? = .red
    
    @IBOutlet weak var tagButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    init(delegate: TagCollectionViewCellProtocol, details: String, index: Int) {
//        self.delegate = delegate
//        self.details = details
//        self.index = index
//        super.init
//    }
//
//    convenience init(with borderColor: UIColor, cellBackgroundColor: UIColor, textColor: UIColor, delegate: TagCollectionViewCellProtocol, details: String, index: Int) {
//        self.init(delegate: delegate, details: details, index: index)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        return nil
//    }
    
    func setup(delegate: TagCollectionViewCellProtocol, details: String, index: Int) {
        self.backgroundColor = backgroundColor
        self.tagButton.setTitleColor(textColor, for: .normal)
        self.layer.borderColor = borderColor?.cgColor
        self.tagButton.setTitle(details, for: .normal)
    }
    
    func setup( with borderColor: UIColor, cellBackgroundColor: UIColor, textColor: UIColor, delegate: TagCollectionViewCellProtocol, details: String, index: Int) {
        self.borderColor = borderColor
        self.cellBackgroundColor = cellBackgroundColor
        self.textColor = textColor
        
        self.setup(delegate: delegate, details: details, index: index)
    }

    @IBAction func tagButtonAction(_ sender: Any) {
        delegate?.buttonClicked()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutIfNeeded()
        let layoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutAttributes.bounds.size = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
        return layoutAttributes
    }
}
