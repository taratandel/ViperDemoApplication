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
    
    // MARK: - @IBOutlets
    @IBOutlet weak var tagDetailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(delegate: TagCollectionViewCellProtocol, details: String, index: Int) {
        self.delegate = delegate
        self.details = details
        self.index = index
        setupUI()
    }
    
    func setup( with borderColor: UIColor, cellBackgroundColor: UIColor, textColor: UIColor, delegate: TagCollectionViewCellProtocol, details: String, index: Int) {
        self.borderColor = borderColor
        self.cellBackgroundColor = cellBackgroundColor
        self.textColor = textColor
        
        self.setup(delegate: delegate, details: details, index: index)
    }
    
    private func setupUI() {
        self.backgroundColor = backgroundColor
        self.layer.borderColor = borderColor?.cgColor
        self.layer.borderWidth = 1
        self.tagDetailLabel.text = details
        self.tagDetailLabel.font = UIFont.defaultFont
        self.tagDetailLabel.textColor = textColor
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let newlayoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        let att = layoutAttributes
        
        att.frame.size.width = newlayoutAttributes.frame.width
        return att
    }
    
    override func select(_ sender: Any?) {
        delegate?.buttonClicked()
    }
}
