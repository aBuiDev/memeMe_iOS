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
    
    private var memeMeDetailsToolbarCloseButton: UIButton = {
        let uiButton = UIButton()
        uiButton.translatesAutoresizingMaskIntoConstraints = false
        uiButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        uiButton.tintColor = .white
        uiButton.addTarget(self, action: #selector(didPressCloseButton), for: .touchUpInside)
        return uiButton
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
    
    @objc func didPressCloseButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    private var memeImageOriginal: UIImageView = {
        let uiImageView = UIImageView()
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        uiImageView.backgroundColor = .black
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
        memeImageOriginal.image = memeDetails.originalImage
        memeBottomLabel.text = memeDetails.bottomText
        
        // Details Toolbar
        view.addSubview(memeMeDetailsToolbar)
        memeMeDetailsToolbar.addSubview(memeMeDetailsToolbarCloseButton)
        
        // Meme Elements
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
            memeMeDetailsToolbarCloseButton.centerYAnchor.constraint(equalTo: memeMeDetailsToolbar.centerYAnchor),
            memeMeDetailsToolbarCloseButton.trailingAnchor.constraint(equalTo: memeMeDetailsToolbar.trailingAnchor, constant: -25.0)
        ])
        
        NSLayoutConstraint.activate([
            memeTopLabel.topAnchor.constraint(equalTo: memeMeDetailsToolbar.bottomAnchor, constant: 25.0),
            memeTopLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10.0),
            memeTopLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -10.0),
            memeTopLabel.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        
        NSLayoutConstraint.activate([
            memeImageOriginal.topAnchor.constraint(equalTo: memeTopLabel.bottomAnchor, constant: 0.0),
            memeImageOriginal.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            memeImageOriginal.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            memeImageOriginal.bottomAnchor.constraint(equalTo: memeBottomLabel.topAnchor, constant: 0.0)
        ])
        
        NSLayoutConstraint.activate([
            memeBottomLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10.0),
            memeBottomLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -10.0),
            memeBottomLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25.0),
            memeBottomLabel.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }
}
