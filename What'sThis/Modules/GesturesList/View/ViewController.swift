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
    
    var gesture = [Gestures]()
    var presenter: GestureListPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showIndicatorView(with: "Wait :/")
        gesturesCollectionView?.delegate = self
        gesturesCollectionView?.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter?.mainViewDidLoad()
    }
    
    func reloadData(listOfGestures: [Gestures]) {
        removeIndicator()
        gesture = listOfGestures
        gesturesCollectionView?.reloadData()
    }
    
    func fetchFailed(title: String, message: String, actions: [UIAlertAction]) {
        removeIndicator()
        gesture = [Gestures]()
        showAlert(title: title, message: message, actions: actions)
    }
    
//    func showIndicatorView
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gesture.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let gestureCell = gesturesCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GestureCollectionViewCell
        
        gestureCell.fillData(gesture[indexPath.row])
        return gestureCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectGesture(id: gesture[indexPath.row].id)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
}
