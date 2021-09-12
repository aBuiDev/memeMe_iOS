//
//  MemeMeCollectionGalleryViewController.swift
//  memeMe_iOS
//
//  Created by Andrew Bui on 11/9/21.
//

import Foundation
import UIKit

class MemeMeSentMemesCollectionViewController: UIViewController, UICollectionViewDelegate {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Collection Gallery"
        view.backgroundColor = .black
        
        navigationItem.rightBarButtonItem = createMemeButton
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    @objc func didPressCreateMemeButton(_ sender: UIBarButtonItem) {
        let memeMeMainViewController = MemeMeMainViewController()
        navigationController?.present(memeMeMainViewController, animated: true, completion: nil)
    }
}


