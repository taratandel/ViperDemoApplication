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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topBarCollectionView: UICollectionView!
    
    // MARK: - Properties
    var scopes: [String]?
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)

    weak var delegate: TopBarViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.topBarCollectionView.delegate = self
        self.topBarCollectionView.dataSource = self
    
        
        setupUI()
    }
    
    func setupUI() {
       let nibName = UINib(nibName: "TagCollectionViewCell", bundle: nil)
        topBarCollectionView.register(nibName, forCellWithReuseIdentifier: "TagCollectionViewCell")
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 110, height: 32.0)
        self.topBarCollectionView.collectionViewLayout = layout
        self.topBarCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: "TagCollectionViewCell")
        topBarCollectionView.reloadData()
        topBarCollectionView.layoutIfNeeded()
    }

    func scrollToTop() {
        scrollView.setContentOffset(.zero, animated: true)
    }
}

extension TopBarViewController: UICollectionViewDelegate {
    
}

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
        let cell = topBarCollectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell", for: indexPath) as! TagCollectionViewCell
        cell.setup(delegate: self, details: scopes[indexPath.row], index: indexPath.row)
        return cell
    }
}

extension TopBarViewController: TagCollectionViewCellProtocol {
    func buttonClicked() {
        print("clicked")
    }
}

extension TopBarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110.0, height: 32.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
