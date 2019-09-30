//
//  TagBarViewController.swift
//  What'sThis
//
//  Created by Tara Tandel on 20/09/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import UIKit



class TopBarViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var topBarCollectionView: UICollectionView!
    
    // MARK: - Properties
    var scopes: [String]?
    private let sectionInsets = UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)
    private var selectedIndexPath: IndexPath? = nil
    
    weak var delegate: TopBarPresenterProtcol?
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        let nib = UINib(nibName: "TagCollectionViewCell", bundle: nil)
        topBarCollectionView.register(nib, forCellWithReuseIdentifier: "TagCell")
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionViewFlowLayout.scrollDirection = .horizontal
        
        topBarCollectionView.collectionViewLayout = collectionViewFlowLayout
        topBarCollectionView.contentInsetAdjustmentBehavior = .always
        topBarCollectionView.collectionViewLayout.invalidateLayout()
        self.topBarCollectionView.delegate = self
        self.topBarCollectionView.dataSource = self
        
    }
}

// MARK: - UICollectionViewDelegate
extension TopBarViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = selectedIndexPath != nil ? nil : indexPath

        guard let cell = topBarCollectionView.cellForItem(at: indexPath) as? TagCollectionViewCell else { return }
        cell.tapped(shouldSelect: selectedIndexPath != nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = topBarCollectionView.cellForItem(at: indexPath) as? TagCollectionViewCell else { return }
        cell.tapped(shouldSelect: false, with: selectedIndexPath?.row )
        selectedIndexPath = nil
    }
}
// MARK: - UICollectionViewDataSource
extension TopBarViewController: UICollectionViewDataSource {
        func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scopes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let scopes = self.scopes else {
            return UICollectionViewCell()
        }
        let cell = topBarCollectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCollectionViewCell
        cell.setup(delegate: self, details: scopes[indexPath.row], index: indexPath.row)
        return cell
    }
}
 // MARK: - TagColectionViewCellProtocol
extension TopBarViewController: TagCollectionViewCellProtocol {
    func buttonClicked(at index: Int, shouldSelect: Bool) {
        if scopes?.count ?? -1 > index && shouldSelect {
            guard let headerTitle = scopes?[index] else { return }
            self.delegate?.tagDidSelectedWith(headerTitle)
        } else {
            self.delegate?.tagDidSelected()
        }
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension TopBarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 28.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
