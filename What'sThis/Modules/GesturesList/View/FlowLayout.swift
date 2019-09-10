//
//  FlowLayout.swift
//  What'sThis
//
//  Created by Tara Tandel on 10/09/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import UIKit

class FlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        
        self.minimumInteritemSpacing = 10
        self.minimumLineSpacing = 10
        self.sectionInset = UIEdgeInsets(top: 50.0,
                                         left: 20.0,
                                         bottom: 50.0,
                                         right: 20.0)
        estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let layoutAttributes = super.layoutAttributesForItem(at: indexPath) else { return nil }
        guard let collectionView = collectionView else { return nil }
        let paddingSpace = sectionInset.left * CGFloat(3 + 1)
        let availableWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width - paddingSpace
        let widthPerItem = availableWidth / CGFloat(3)

        layoutAttributes.bounds.size.width = widthPerItem
        return layoutAttributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superLayoutAttributes = super.layoutAttributesForElements(in: rect) else { return nil }
        guard scrollDirection == .vertical else { return superLayoutAttributes }
        
        let computedAttributes = superLayoutAttributes.compactMap { layoutAttribute in
            return layoutAttribute.representedElementCategory == .cell ? layoutAttributesForItem(at: layoutAttribute.indexPath) : layoutAttribute
        }
        return computedAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
