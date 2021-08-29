//
//  ViewController.swift
//  memeMe_iOS
//
//  Created by Andrew Bui on 29/8/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MemeMe Image View
    private var imageDisplayView: UIImageView = {
        let uiImageView = UIImageView()
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        uiImageView.layer.borderWidth = 2.0
        uiImageView.layer.borderColor = CGColor(red: 250, green: 250, blue: 250, alpha: 1.0)
        uiImageView.backgroundColor = .systemGray
        return uiImageView
    }()
    
    // MemeMe Toolbar
    private var memeToolbar: UIToolbar = {
        let uiToolbar = UIToolbar()
        uiToolbar.translatesAutoresizingMaskIntoConstraints = false
        uiToolbar.layer.backgroundColor = CGColor(red: 128.0, green: 128.0, blue: 128.0, alpha: 0.5)
        uiToolbar.backgroundColor = .cyan
        return uiToolbar
    }()
    
    private var memeToolbarImagePickerButton: UIButton = {
        let uiButton = UIButton()
        uiButton.translatesAutoresizingMaskIntoConstraints = false
        uiButton.setTitle("Gallery", for: .normal)
        uiButton.setTitleColor(.systemBlue, for: .normal)
        uiButton.addTarget(self, action: #selector(didPressGalleryButton), for: .touchUpInside)
        return uiButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageDisplayView)
        view.addSubview(memeToolbar)
        memeToolbar.addSubview(memeToolbarImagePickerButton)
        
        NSLayoutConstraint.activate([
            imageDisplayView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200.0),
            imageDisplayView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.0),
            imageDisplayView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.0),
            imageDisplayView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200.0),
        ])
        
        NSLayoutConstraint.activate([
            memeToolbar.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0.0),
            memeToolbar.heightAnchor.constraint(equalToConstant: 80.0),
            memeToolbar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0)
        ])
        
        NSLayoutConstraint.activate([
            memeToolbarImagePickerButton.topAnchor.constraint(equalTo: memeToolbar.topAnchor, constant: 30.0),
            memeToolbarImagePickerButton.leadingAnchor.constraint(equalTo: memeToolbar.leadingAnchor, constant: 25.0),
            memeToolbarImagePickerButton.bottomAnchor.constraint(equalTo: memeToolbar.bottomAnchor, constant: -30.0),
        ])
    }
    
    @objc func didPressGalleryButton() {
        let pickerController = UIImagePickerController()
        present(pickerController, animated: true, completion: nil)
    }

}

