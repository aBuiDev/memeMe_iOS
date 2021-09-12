//
//  MemeMeCollectionGalleryViewController.swift
//  memeMe_iOS
//
//  Created by Andrew Bui on 11/9/21.
//

import Foundation
import UIKit

class MemeMeSentMemesCollectionViewController: UIViewController, UICollectionViewDelegate {
    
    var count: Int = 0
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    lazy var createMemeButton: UIBarButtonItem = {
        let uiBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus.square"),
            style: .plain,
            target: self,
            action: #selector(didPressCreateMemeButton(_:))
        )
        return uiBarButtonItem
    }()
    
    private var memeMeCollectionView: UICollectionView = {
        
        let uiCollectionViewFlowLayout = UICollectionViewFlowLayout()
        uiCollectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        uiCollectionViewFlowLayout.itemSize = CGSize(width: 120, height: 120)
        
        let uiCollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: uiCollectionViewFlowLayout
        )
    
        uiCollectionView.backgroundColor = .systemRed
        return uiCollectionView
    }()
    
    private var forCellWithReuseIdentifier = "memeCollectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memeMeCollectionView.delegate = self
        memeMeCollectionView.dataSource = self
        memeMeCollectionView.frame = self.view.frame
        memeMeCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: forCellWithReuseIdentifier)
        
        title = "Collection Gallery"
        view.backgroundColor = .black
        
        navigationItem.rightBarButtonItem = createMemeButton
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        // Collection Gallery
        view.addSubview(memeMeCollectionView)
        
        // Collection Gallary Constraints
        NSLayoutConstraint.activate([
            memeMeCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            memeMeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            memeMeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            memeMeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0)
        ])
    }
    
    @objc func didPressCreateMemeButton(_ sender: UIBarButtonItem) {
        let memeMeMainViewController = MemeMeMainViewController()
        navigationController?.present(memeMeMainViewController, animated: true, completion: nil)
    }
}

extension MemeMeSentMemesCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: forCellWithReuseIdentifier, for: indexPath)
        myCell.backgroundColor = UIColor.blue
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Hello World")
    }
}


