//
//  MemeMeCollectionGalleryViewController.swift
//  memeMe_iOS
//
//  Created by Andrew Bui on 11/9/21.
//

import Foundation
import UIKit

class MemeMeSentMemesCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var forCellWithReuseIdentifier = "memeCollectionCell"
    
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
        uiCollectionViewFlowLayout.itemSize = CGSize(width: 125, height: 175)
        
        let uiCollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: uiCollectionViewFlowLayout
        )
    
        uiCollectionView.translatesAutoresizingMaskIntoConstraints = false
        uiCollectionView.backgroundColor = .black
        return uiCollectionView
    }()
    
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    
    
    // MARK: SetupViews
    func setupViews() {
        
        memeMeCollectionView.delegate = self
        memeMeCollectionView.dataSource = self
        memeMeCollectionView.register(MemeCollectionViewCell.self, forCellWithReuseIdentifier: forCellWithReuseIdentifier)
        
        title = "Collection Gallery"
        view.backgroundColor = .black
        
        navigationItem.rightBarButtonItem = createMemeButton
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        // Collection Gallery
        view.addSubview(memeMeCollectionView)
        
        // Collection Gallery Constraints
        NSLayoutConstraint.activate([
            memeMeCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            memeMeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            memeMeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            memeMeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0)
        ])
    }
    
    
    
    // MARK: Functions
    @objc func didPressCreateMemeButton(_ sender: UIBarButtonItem) {
        let memeMeMainViewController = MemeMeMainViewController()
        navigationController?.present(memeMeMainViewController, animated: true, completion: nil)
    }
    
    
    
    // MARK: CollectionViewDelegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: forCellWithReuseIdentifier, for: indexPath) as! MemeCollectionViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]

        myCell.topMemeText.text = meme.topText
        myCell.bottomMemeText.text = meme.bottomText
        myCell.memeImage.image = meme.originalImage
        
        myCell.backgroundColor = .white

        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let meme = self.memes[(indexPath as NSIndexPath).row]
        let memeMeMemeDetailsViewController = MemeMeMemeDetailsViewController(memeDetails: meme)
        self.navigationController?.present(memeMeMemeDetailsViewController, animated: true, completion: nil)
    }
}



// MARK: MemeCollectionViewCell
class MemeCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let topMemeText: UILabel = {
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.textAlignment = .center
        uiLabel.numberOfLines = 0
        return uiLabel
    }()
    
    let bottomMemeText: UILabel = {
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.textAlignment = .center
        uiLabel.numberOfLines = 0
        return uiLabel
    }()
    
    var memeImage: UIImageView = {
        let uiImage = UIImageView()
        uiImage.translatesAutoresizingMaskIntoConstraints = false
        uiImage.contentMode = .scaleAspectFill
        uiImage.clipsToBounds = true
        return uiImage
    }()
    
    func setupViews() {
        addSubview(topMemeText)
        addSubview(memeImage)
        addSubview(bottomMemeText)

        // Top Meme Text Constraints
        NSLayoutConstraint.activate([
            topMemeText.topAnchor.constraint(equalTo: self.topAnchor),
            topMemeText.heightAnchor.constraint(equalToConstant: 25.0),
            topMemeText.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        // Image Constraints
        NSLayoutConstraint.activate([
            memeImage.topAnchor.constraint(equalTo: topMemeText.bottomAnchor),
            memeImage.widthAnchor.constraint(equalTo: self.widthAnchor),
            memeImage.bottomAnchor.constraint(equalTo: bottomMemeText.topAnchor),
        ])
        
        // Bottom Meme Text Constraints
        NSLayoutConstraint.activate([
            bottomMemeText.heightAnchor.constraint(equalToConstant: 25.0),
            bottomMemeText.widthAnchor.constraint(equalTo: self.widthAnchor),
            bottomMemeText.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}

