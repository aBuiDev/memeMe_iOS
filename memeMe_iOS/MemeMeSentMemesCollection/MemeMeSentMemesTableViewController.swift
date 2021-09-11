//
//  MemeMeSentMemesTableViewController.swift
//  memeMe_iOS
//
//  Created by Andrew Bui on 11/9/21.
//

import Foundation
import UIKit

class MemeMeSentMemesTableViewController: UIViewController, UITableViewDelegate {
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    private var createMemeButton: UIBarButtonItem = {
        let uiBarButtonItem = UIBarButtonItem()
        uiBarButtonItem.image = UIImage(systemName: "plus.square")
        return uiBarButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Table Gallery"
        view.backgroundColor = .systemBlue
        
        navigationItem.rightBarButtonItem = createMemeButton
    }
}
