//
//  ViewController.swift
//  What'sThis
//
//  Created by Tara Tandel on 06/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import UIKit

class ViewController: BaseViewController, GestureListViewProtocol {

    @IBOutlet weak var gesturesCollectionView: UICollectionView!
    
    var presenter: GestureListPresenterProtocol!
    
    private let itemsPerRow = 3
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)

    
    var largePhotoIndexPath: IndexPath? {
        didSet {
            var indexPaths: [IndexPath] = []
            if let largePhotoIndexPath = largePhotoIndexPath {
                indexPaths.append(largePhotoIndexPath)
            }
            
            if let oldValue = oldValue {
                indexPaths.append(oldValue)
            }
            
            gesturesCollectionView.performBatchUpdates({
                self.gesturesCollectionView.reloadItems(at: indexPaths)
            }, completion: {[weak self] _ in
                if let largePhotoIndexPath = self?.largePhotoIndexPath {
                    self?.gesturesCollectionView.scrollToItem(at: largePhotoIndexPath, at: .centeredVertically, animated: true)
                }
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        showIndicatorView(with: "Wait :/")
        (gesturesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        (gesturesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInsetReference = .fromLayoutMargins
        
        gesturesCollectionView.contentInsetAdjustmentBehavior = .always
        
        gesturesCollectionView?.delegate = self
        gesturesCollectionView?.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter?.mainViewDidLoad()
    }
    
    func reloadData(listOfGestures: [String: [Gestures]], listOfHeaders: [String]) {
        removeIndicator()
        gesturesCollectionView?.reloadData()
        gesturesCollectionView.layoutIfNeeded()
    }
    
    func fetchFailed(title: String, message: String, actions: [UIAlertAction]) {
        removeIndicator()
        showAlert(title: title, message: message, actions: actions)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getTheNumberOfItemsInSection(section) ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.presenter.getTheNumberOfSections() ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let gestureCell = gesturesCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GestureCollectionViewCell
        guard let gestureDataToBuild = presenter.getGesturesForHeader(at: indexPath) else {
            return UICollectionViewCell()
        }
        gestureCell.fillData(gestureDataToBuild)
        return gestureCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = presenter.getGesturesForHeader(at: indexPath)?.id else {
            return
        }
        presenter?.didSelectGesture(id: id)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if largePhotoIndexPath == indexPath {
            largePhotoIndexPath = nil
            return true
        } else {
            largePhotoIndexPath = indexPath
            return false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard
                let headerView = gesturesCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(HeaderCollectionReusableView.self)", for: indexPath) as? HeaderCollectionReusableView else {
                    fatalError()
            }
            let headerTerm = presenter.getTheTitleHeader(at: indexPath.section)
            headerView.sectionHeaderLabel.text = headerTerm
            return headerView
        default:
            assert(false, "Invalid element type")
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath == largePhotoIndexPath {
            var size = collectionView.bounds.size
            size.height -= (sectionInsets.top + sectionInsets.right)
            size.width -= (sectionInsets.left + sectionInsets.right)
            return size
        }
        let paddingSpace = sectionInsets.left * CGFloat(itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / CGFloat(itemsPerRow)

        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }

}
