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
    
    private var memeMeDetailsToolbar: UIToolbar = {
        let uiToolbar = UIToolbar()
        uiToolbar.translatesAutoresizingMaskIntoConstraints = false
        uiToolbar.barTintColor = .black
        uiToolbar.sizeToFit()
        return uiToolbar
    }()
    
    private lazy var memeTopLabel: UILabel = {
        createMemeUILabel()
    }()
    
    private lazy var memeBottomLabel: UILabel = {
        createMemeUILabel()
    }()
    
    func createMemeUILabel() ->  UILabel {
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.textAlignment = .center
        uiLabel.textColor = .white
        uiLabel.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)
        uiLabel.numberOfLines = 0
        return uiLabel
    }
    
    private var memeImageOriginal: UIImageView = {
        let uiImageView = UIImageView()
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        uiImageView.backgroundColor = .red
        uiImageView.contentMode = .scaleAspectFit
        return uiImageView
    }()
    
    init(memeDetails: Meme) {
        self.memeDetails = memeDetails
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        memeTopLabel.text = memeDetails.topText
        
        // Details Toolbar
        view.addSubview(memeMeDetailsToolbar)
        view.addSubview(memeTopLabel)
        view.addSubview(memeImageOriginal)
        view.addSubview(memeBottomLabel)
        
        // Details Toolbar Constraints
        NSLayoutConstraint.activate([
            memeMeDetailsToolbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            memeMeDetailsToolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            memeMeDetailsToolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            memeMeDetailsToolbar.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        
        NSLayoutConstraint.activate([
            memeTopLabel.topAnchor.constraint(equalTo: memeMeDetailsToolbar.bottomAnchor, constant: 25.0),
            memeTopLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10.0),
            memeTopLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -10.0),
            memeTopLabel.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }
}
