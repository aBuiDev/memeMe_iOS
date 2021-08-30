//
//  ViewController.swift
//  memeMe_iOS
//
//  Created by Andrew Bui on 29/8/21.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MemeMe Image View
    private var imageDisplayView: UIImageView = {
        let uiImageView = UIImageView()
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        uiImageView.contentMode = .scaleAspectFill
        uiImageView.clipsToBounds = true
        return uiImageView
    }()
    
    // MemeMe Toolbar
    private var memeToolbar: UIToolbar = {
        let uiToolbar = UIToolbar()
        uiToolbar.translatesAutoresizingMaskIntoConstraints = false
//        uiToolbar.layer.backgroundColor = CGColor(red: 128.0, green: 128.0, blue: 128.0, alpha: 0.5)
        uiToolbar.backgroundColor = .systemOrange
        return uiToolbar
    }()
    
    private var memeToolbarImagePickerButton: UIButton = {
        let uiButton = UIButton()
        uiButton.translatesAutoresizingMaskIntoConstraints = false
        uiButton.setTitle("Gallery", for: .normal)
        uiButton.setTitleColor(.systemGray, for: .normal)
        uiButton.addTarget(self, action: #selector(didPressGalleryButton), for: .touchUpInside)
        return uiButton
    }()
    
    private var memeToolbarCameraButton: UIButton = {
        let uiButton = UIButton()
        uiButton.translatesAutoresizingMaskIntoConstraints = false
        uiButton.setTitle("Camera", for: .normal)
        uiButton.setTitleColor(.systemGray, for: .normal)
        uiButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        uiButton.addTarget(self, action: #selector(didPressCameraButton), for: .touchUpInside)
        return uiButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageDisplayView)
        view.addSubview(memeToolbar)
        memeToolbar.addSubview(memeToolbarImagePickerButton)
        memeToolbar.addSubview(memeToolbarCameraButton)
        
        NSLayoutConstraint.activate([
            imageDisplayView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0),
            imageDisplayView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            imageDisplayView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -0.0),
            imageDisplayView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -0.0),
        ])
        
        NSLayoutConstraint.activate([
            memeToolbar.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0.0),
            memeToolbar.heightAnchor.constraint(equalToConstant: 80.0),
            memeToolbar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0)
        ])
        
        NSLayoutConstraint.activate([
            memeToolbarImagePickerButton.topAnchor.constraint(equalTo: memeToolbar.topAnchor, constant: 20.0),
            memeToolbarImagePickerButton.leadingAnchor.constraint(equalTo: memeToolbar.leadingAnchor, constant: 25.0),
            memeToolbarImagePickerButton.bottomAnchor.constraint(equalTo: memeToolbar.bottomAnchor, constant: -40.0),
        ])
        
        NSLayoutConstraint.activate([
            memeToolbarCameraButton.topAnchor.constraint(equalTo: memeToolbar.topAnchor, constant: 20.0),
            memeToolbarCameraButton.trailingAnchor.constraint(equalTo: memeToolbar.trailingAnchor, constant: -25.0),
            memeToolbarCameraButton.bottomAnchor.constraint(equalTo: memeToolbar.bottomAnchor, constant: -40.0),
        ])
    }
    
    @objc func didPressGalleryButton() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func didPressCameraButton() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo: [UIImagePickerController.InfoKey : Any]) {
        if let image = didFinishPickingMediaWithInfo[.originalImage] as? UIImage {
            imageDisplayView.image = image
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }


}

