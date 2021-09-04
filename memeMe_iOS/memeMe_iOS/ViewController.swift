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
    
    
    
    // MARK: MemeMe Toolbar
    private var memeToolbar: UIToolbar = {
        let uiToolbar = UIToolbar()
        uiToolbar.translatesAutoresizingMaskIntoConstraints = false
        uiToolbar.barTintColor = .systemGreen
        uiToolbar.sizeToFit()
        return uiToolbar
    }()
    
    private var memeToolbarImagePickerButton: UIBarButtonItem = {
        let uiBarButtonItem = UIBarButtonItem(
            title: "Gallery",
            style: .plain,
            target: self,
            action: #selector(didPressGalleryButton)
        )
        uiBarButtonItem.tintColor = .white
        uiBarButtonItem.isEnabled = true
        return uiBarButtonItem
    }()

    private var memeToolbarSaveButton: UIBarButtonItem = {
        let uiBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .plain,
            target: self,
            action: #selector(didPressSaveButton)
        )
        uiBarButtonItem.tintColor = .white
        uiBarButtonItem.isEnabled = false
        return uiBarButtonItem
    }()
    
    private var memeToolbarCameraButton: UIBarButtonItem = {
        let uiBarButtonItem = UIBarButtonItem(
            title: "Camera",
            style: .plain,
            target: self,
            action: #selector(didPressCameraButton)
        )
        uiBarButtonItem.tintColor = .white
        uiBarButtonItem.isEnabled = true
        return uiBarButtonItem
    }()
    
    private let memeToolbarFlexibleSpacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

    // Top Text Field
    internal var topTextField: UITextField = {
        let uiTextField = UITextField()
        uiTextField.translatesAutoresizingMaskIntoConstraints = false
        uiTextField.autocapitalizationType = .allCharacters
        uiTextField.textAlignment = .center
        uiTextField.placeholder = "Top Text Here..."
        uiTextField.isHidden = true
        return uiTextField
    }()
    
    // Bottom Text Field
    internal var bottomTextField: UITextField = {
        let uiTextField = UITextField()
        uiTextField.translatesAutoresizingMaskIntoConstraints = false
        uiTextField.autocapitalizationType = .allCharacters
        uiTextField.textAlignment = .center
        uiTextField.placeholder = "Bottom Text Here..."
        uiTextField.isHidden = true
        return uiTextField
    }()

    
    
    // MARK: Initialisation
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialise Navigation Controller
        self.title = "MemeMe 1.0"
        self.navigationController?.navigationBar.barTintColor = .systemPurple
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        topTextField.delegate = topTextFieldDelegate
        bottomTextField.delegate = bottomTextFieldDelegate
        
        view.addSubview(imageDisplayView)
        view.addSubview(topTextField)
        view.addSubview(bottomTextField)
        
        view.addSubview(memeToolbar)
        memeToolbar.items = setupToolbarItems()

        NSLayoutConstraint.activate([
            imageDisplayView.topAnchor.constraint(equalTo: view.topAnchor, constant: 125.0),
            imageDisplayView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.0),
            imageDisplayView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.0),
            imageDisplayView.bottomAnchor.constraint(equalTo: memeToolbar.topAnchor, constant: -30.0)
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeToKeyboardNotifications()
    }
    
    
    
    // MARK: UI Toolbar Methods
    @objc func didPressGalleryButton() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func didPressSaveButton() {
        let memedImage: UIImage = generateMemedImage()
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageDisplayView.image!, memedImage: memedImage)
        print("\(meme.topText) \(meme.bottomText) saved to storage...")
    }
    
    @objc func didPressCameraButton() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func setupToolbarItems() -> [UIBarButtonItem] {
        var uiBarButtonItems: [UIBarButtonItem] = []
        uiBarButtonItems.append(memeToolbarFlexibleSpacer)
        uiBarButtonItems.append(memeToolbarImagePickerButton)
        uiBarButtonItems.append(memeToolbarFlexibleSpacer)
        uiBarButtonItems.append(memeToolbarSaveButton)
        uiBarButtonItems.append(memeToolbarFlexibleSpacer)
        uiBarButtonItems.append(memeToolbarCameraButton)
        uiBarButtonItems.append(memeToolbarFlexibleSpacer)
        return uiBarButtonItems
    }
    
    

    // MARK: Sharing
    @objc func didPressShareButton() {
        let savedImage = generateMemedImage()
        let imageItems: [UIImage] = [savedImage]
        let activityViewController = UIActivityViewController(activityItems: imageItems, applicationActivities: nil)
        present(activityViewController, animated: true)
    }
    
    
    // MARK: Image Picker Controller
    func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo: [UIImagePickerController.InfoKey : Any]) {
        if let image = didFinishPickingMediaWithInfo[.originalImage] as? UIImage {
            // Displaying Selected Image from Gallary in Image Display View
            imageDisplayView.image = image
            
            // Initialise Centering of Text using NSMutableParagraphStyle
            let centerAttributedText = NSMutableParagraphStyle()
            centerAttributedText.alignment = .center

            // Re-initialised Top Text Field
            topTextField.isHidden = false
            topTextField.defaultTextAttributes = memeTextAttributes
            topTextField.attributedText = NSAttributedString(string: "TOP TEXT", attributes: [.paragraphStyle: centerAttributedText])
            
            // Re-initialised Bottom Text Field
            bottomTextField.isHidden = false
            bottomTextField.defaultTextAttributes = memeTextAttributes
            bottomTextField.attributedText = NSAttributedString(string: "BOTTOM TEXT", attributes: [.paragraphStyle: centerAttributedText])
            
            // Enable Save Button
            memeToolbarSaveButton.isEnabled = true
            
            // Enable Share Button
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(didPressShareButton))
            self.navigationItem.leftBarButtonItem?.tintColor = .white
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // MARK: NotificationCenter for Keyboard
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
    
    
    
    // MARK: Saving Meme
    struct Meme {
        var topText: String
        var bottomText: String
        var originalImage: UIImage
        var memedImage: UIImage
    }
    
    func generateMemedImage() -> UIImage {

        // Hide Toolbar
        memeToolbar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: false)
    
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        // Unhide Toobar
        memeToolbar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: false)

        return memedImage
    }
}



// MARK: Text Field Delegates
// BottomTextField Delegate
class TopTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text == "" {
            textField.placeholder = "Top Text Here..."
        }
        textField.textAlignment = .center
        textField.autocorrectionType = .no
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        textField.textAlignment = .center
        textField.autocorrectionType = .no
    }
}



// BottomTextField Delegate
class BottomTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text == "" {
            textField.placeholder = "Bottom Text Here..."
        }
        textField.textAlignment = .center
        textField.autocorrectionType = .no
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        textField.textAlignment = .center
        textField.autocorrectionType = .no
    }
}

