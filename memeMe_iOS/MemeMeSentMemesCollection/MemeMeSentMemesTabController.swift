//
//  MemeMeSentMemesTabController.swift
//  memeMe_iOS
//
//  Created by Andrew Bui on 11/9/21.
//

import Foundation
import UIKit

class MemeMeSentMemesTabBarController: UIViewController {
    
    let memeMeSentMemesCollectionViewController = MemeMeSentMemesCollectionViewController()
    let memeMeSentMemesTableViewController = MemeMeSentMemesTableViewController()
        
    override func viewDidLoad() {
        let memeMeSentMemesTabBarController = UITabBarController()
        memeMeSentMemesTabBarController.setViewControllers([memeMeSentMemesCollectionViewController, memeMeSentMemesTableViewController], animated: true)
        memeMeSentMemesTabBarController.modalPresentationStyle = .fullScreen
    }
}
