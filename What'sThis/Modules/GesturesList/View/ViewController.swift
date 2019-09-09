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
    
    var gesture = [String: [Gestures]]()
    var presenter: GestureListPresenterProtocol!
    
    private let itemsPerRow = 3
    
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)
    
    private var headerItems = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showIndicatorView(with: "Wait :/")
        gesturesCollectionView?.delegate = self
        gesturesCollectionView?.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter?.mainViewDidLoad()
    }
    
    func reloadData(listOfGestures: [String: [Gestures]], listOfHeaders: [String]) {
        removeIndicator()
        gesture = listOfGestures
        headerItems = listOfHeaders
        gesturesCollectionView?.reloadData()
        gesturesCollectionView.layoutIfNeeded()
    }
    
    func fetchFailed(title: String, message: String, actions: [UIAlertAction]) {
        removeIndicator()
        gesture = [String: [Gestures]]()
        showAlert(title: title, message: message, actions: actions)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gesture[headerItems[section]]?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return gesture.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let gestureCell = gesturesCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GestureCollectionViewCell
        guard let gestureDataToBuild = gesture[headerItems[indexPath.section]]?[indexPath.row] else {
            return UICollectionViewCell()
        }
        gestureCell.fillData(gestureDataToBuild)
        return gestureCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        presenter?.didSelectGesture(id: gesture[indexPath.row].id)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
