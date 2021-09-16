//
//  MemeMeMemeDetailsViewController.swift
//  memeMe_iOS
//
//  Created by Andrew Bui on 12/9/21.
//

import Foundation
import UIKit

class MemeMeMemeDetailsViewController: UIViewController {
    
    var memeDetails: Meme
    
    init(memeDetails: Meme) {
        self.memeDetails = memeDetails
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        print(memeDetails.bottomText)
    }
}
