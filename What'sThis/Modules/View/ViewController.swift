//
//  ViewController.swift
//  What'sThis
//
//  Created by Tara Tandel on 06/08/2019.
//  Copyright © 2019 Tara Tandel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GestureListViewProtocol {

    @IBOutlet weak var gesturesCollectionView: UICollectionView!
    
    var gesture = [Gestures]()
    var presenter: GestureListPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gesturesCollectionView?.delegate = self
        gesturesCollectionView?.dataSource = self
        
        presenter?.mainViewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func reloadData(listOfGestures: ArrayOfGestures) {
        gesture = listOfGestures.data
        gesturesCollectionView?.reloadData()
    }
    func fetchFaild(title: String, message: String) {
        let buttons = ButtonsAction.init(title: "cancel", style: .cancel, handler: {action in
            //here I want to dissmiss the alert I dont know how
        })
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert).showAlert(buttons: nil)
        alert.show(self, sender: nil)
        
    }
    func fetchFailed () {
        let buttons = ButtonsAction.init(title: "title", style: .cancel, handler: {
            alert.dissmiss
        })
        let alert = UIAlertController().showAlert(buttons: buttons).show(

    }
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
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
}

