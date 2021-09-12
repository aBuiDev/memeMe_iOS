//
//  MemeMeSentMemesViewController.swift
//  memeMe_iOS
//
//  Created by Andrew Bui on 11/9/21.
//

import Foundation
import UIKit

class MemeMeSentMemesViewController: UIViewController {
    
    override func viewDidLoad() {
        let tabBarViewController = UITabBarController()
        
        tabBarViewController.tabBar.barTintColor = .black
        tabBarViewController.tabBar.tintColor = .white
        
        let memeMeSentMemesCollectionViewController = UINavigationController(rootViewController: MemeMeSentMemesCollectionViewController())
        memeMeSentMemesCollectionViewController.title = "Collection Gallery"
        let memeMeSentMemesTableViewController = UINavigationController(rootViewController: MemeMeSentMemesTableViewController())
        memeMeSentMemesTableViewController.title = "Table Gallery"
        
        tabBarViewController.setViewControllers([memeMeSentMemesCollectionViewController, memeMeSentMemesTableViewController], animated: false)
        
        guard let items = tabBarViewController.tabBar.items else {
            return
        }
        
        for item in items {
            if item.title == "Collection Gallery" {
                item.image = UIImage(systemName: "square.grid.2x2")
            } else if item.title == "Table Gallery" {
                item.image = UIImage(systemName: "list.bullet")
            }
        }
        
        tabBarViewController.modalPresentationStyle = .fullScreen
        
        present(tabBarViewController, animated: true)
    }
}



