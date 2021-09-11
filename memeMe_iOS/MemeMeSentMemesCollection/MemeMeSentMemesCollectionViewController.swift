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
    
    override func viewDidLoad() {
        print("Hello World")
    }
}


