//
//  TagCollectionViewCell.swift
//  What'sThis
//
//  Created by Tara Tandel on 23/09/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import UIKit
protocol TagCollectionViewCellProtocol: class {
    func buttonClicked(at index: Int, shouldSelect: Bool)
}
class TagCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Delegates
    weak var delegate: TagCollectionViewCellProtocol?
    
    // MARK: - Properties
    var details: String = ""
    var index: Int = -1
    
    var borderColor: UIColor? = .red
    var cellBackgroundColor: UIColor? = .white
    var textColor: UIColor? = .red
    
    private var isSelectedBefore: Bool = false
    
    override var isSelected: Bool {
        didSet {
            if index != -1 && !oldValue {
                isSelectedBefore = !isSelectedBefore
                setupUI()
                if !isSelected {return}
                delegate?.buttonClicked(at: index, shouldSelect: isSelectedBefore)
            }
        }
    }
    
    // MARK: - @IBOutlets
    @IBOutlet weak var tagDetailLabel: UILabel!
    @IBOutlet weak var cellBackgroundView: UIView!
    
    // MARK: - Functions
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
        self.tagDetailLabel.backgroundColor = UIColor.clear
        self.cellBackgroundView.backgroundColor = isSelectedBefore ? .red : .white
        self.tagDetailLabel.textColor = isSelectedBefore ? .white : .red

    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let newlayoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        let att = layoutAttributes
        
        att.frame.size.width = newlayoutAttributes.frame.width
        return att
    }
}
