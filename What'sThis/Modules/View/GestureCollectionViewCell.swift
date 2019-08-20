//
//  GestureCollectionViewCell.swift
//  What'sThis
//
//  Created by Tara Tandel on 20/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import UIKit

class GestureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var gestureImage: UIImageView!
    @IBOutlet weak var gestureName: UILabel!
    
    func fillData (_ gesture: Gestures) {
//        self.gestureName.sizeToFit()

        self.gestureImage.image = UIImage(named: gesture.imageName)
        self.gestureImage.backgroundColor = .red
        self.gestureName.text = gesture.name
        self.gestureName.backgroundColor = .darkGray
        self.gestureName.textColor = .white
        self.backgroundColor = .black
    }
}
