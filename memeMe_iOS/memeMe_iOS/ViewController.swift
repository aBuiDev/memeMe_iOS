//
//  ViewController.swift
//  memeMe_iOS
//
//  Created by Andrew Bui on 29/8/21.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    let topTextFieldDelegate = TopTextFieldDelegate()
    let bottomTextFieldDelegate = BottomTextFieldDelegate()
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -3.0
    ]

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
    
    // Top Text Field
    internal var topTextField: UITextField = {
        let uiTextField = UITextField()
        uiTextField.translatesAutoresizingMaskIntoConstraints = false
        uiTextField.autocapitalizationType = .allCharacters
        uiTextField.isHidden = true
        return uiTextField
    }()
    
    // Bottom Text Field
    internal var bottomTextField: UITextField = {
        let uiTextField = UITextField()
        uiTextField.translatesAutoresizingMaskIntoConstraints = false
        uiTextField.autocapitalizationType = .allCharacters
        uiTextField.isHidden = true
        return uiTextField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topTextField.delegate = topTextFieldDelegate
        bottomTextField.delegate = bottomTextFieldDelegate
        
        view.addSubview(imageDisplayView)
        view.addSubview(topTextField)
        view.addSubview(bottomTextField)
        view.addSubview(memeToolbar)
        
        memeToolbar.addSubview(memeToolbarImagePickerButton)
        memeToolbar.addSubview(memeToolbarCameraButton)
        
        NSLayoutConstraint.activate([
            imageDisplayView.topAnchor.constraint(equalTo: view.topAnchor, constant: 125.0),
            imageDisplayView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.0),
            imageDisplayView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.0),
            imageDisplayView.bottomAnchor.constraint(equalTo: memeToolbar.topAnchor, constant: -50.0)
        ])
        
        NSLayoutConstraint.activate([
            topTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 30.0),
            topTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 150.0),
            topTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0),
            topTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0),
        ])
        
        NSLayoutConstraint.activate([
            bottomTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 30.0),
            bottomTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0),
            bottomTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0),
            bottomTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150.0)
        ])
        
        NSLayoutConstraint.activate([
            memeToolbar.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0.0),
            memeToolbar.heightAnchor.constraint(equalToConstant: 80.0),
            memeToolbar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0)
        ])
        
        NSLayoutConstraint.activate([
            memeToolbarImagePickerButton.topAnchor.constraint(equalTo: memeToolbar.topAnchor, constant: 20.0),
            memeToolbarImagePickerButton.leadingAnchor.constraint(equalTo: memeToolbar.leadingAnchor, constant: 25.0),
            memeToolbarImagePickerButton.bottomAnchor.constraint(equalTo: memeToolbar.bottomAnchor, constant: -40.0)
        ])
        
        NSLayoutConstraint.activate([
            memeToolbarCameraButton.topAnchor.constraint(equalTo: memeToolbar.topAnchor, constant: 20.0),
            memeToolbarCameraButton.trailingAnchor.constraint(equalTo: memeToolbar.trailingAnchor, constant: -25.0),
            memeToolbarCameraButton.bottomAnchor.constraint(equalTo: memeToolbar.bottomAnchor, constant: -40.0)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeToKeyboardNotifications()
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
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .center
            imageDisplayView.image = image
            topTextField.isHidden = false
            topTextField.defaultTextAttributes = memeTextAttributes
            topTextField.attributedText = NSAttributedString(string: "TOP TEXT", attributes: [.paragraphStyle: paragraph])
            bottomTextField.isHidden = false
            bottomTextField.defaultTextAttributes = memeTextAttributes
            bottomTextField.attributedText = NSAttributedString(string: "BOTTOM TEXT", attributes: [.paragraphStyle: paragraph])
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // NotificationCenter for Keyboard
    @objc func keyboardWillShow(_ notification: Notification) {
        view.frame.origin.y = -getKeyboardHeight(notification)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notifcation: Notification) -> CGFloat {
        let userInfo = notifcation.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height - 100
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
}



// BottomTextField Delegate
class TopTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.textAlignment = .center
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        textField.textAlignment = .center
    }
}



// BottomTextField Delegate
class BottomTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.textAlignment = .center
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        textField.textAlignment = .center
    }
}

