//
//  ViewController.swift
//  memeMe_iOS
//
//  Created by Andrew Bui on 29/8/21.
//

import UIKit

class MemeMeMainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    let topTextFieldDelegate = MemeMeTextFieldDelegate()
    let bottomTextFieldDelegate = MemeMeTextFieldDelegate()
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor.black,
        .foregroundColor: UIColor.white,
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size:40)!,
        .strokeWidth: -3.0
    ]

    // MemeMe Image View
    private var imageDisplayView: UIImageView = {
        let uiImageView = UIImageView()
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        uiImageView.contentMode = .scaleAspectFit
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
    
    private lazy var memeToolbarImagePickerButton: UIBarButtonItem = {
        let uiBarButtonItem = UIBarButtonItem(
            title: "Gallery",
            style: .plain,
            target: self,
            action: #selector(didSelectImagePickerButton(_ :))
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
    
    private var memeNavigationShareButton: UIButton = {
        let uiButton = UIButton()
        uiButton.setImage(.actions, for: .normal)
        uiButton.sizeToFit()
        uiButton.tintColor = .systemGreen
        uiButton.isEnabled = false
        return uiButton
    }()
    
    private var memeToolbarCameraButton: UIBarButtonItem = {
        let uiBarButtonItem = UIBarButtonItem(
            title: "Camera",
            style: .plain,
            target: self,
            action: #selector(didSelectImagePickerButton(_ :))
        )
        uiBarButtonItem.tintColor = .white
        uiBarButtonItem.isEnabled = true
        uiBarButtonItem.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        return uiBarButtonItem
    }()
    
    private let memeToolbarFlexibleSpacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

    
    
    
    // MARK: Text Fields
    internal lazy var topTextField: UITextField = {
        generateTextField()
    }()
    
    internal lazy var bottomTextField: UITextField = {
        generateTextField()
    }()
    
    private func generateTextField() -> UITextField {
        let uiTextField = UITextField()
            uiTextField.translatesAutoresizingMaskIntoConstraints = false
            uiTextField.autocapitalizationType = .allCharacters
            uiTextField.textAlignment = .center
            uiTextField.isHidden = true
        return uiTextField
    }

    

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
        
        view.backgroundColor = .black
        
        view.addSubview(imageDisplayView)
        view.addSubview(topTextField)
        view.addSubview(bottomTextField)
        
        view.addSubview(memeToolbar)
        memeToolbar.items = setupToolbarItems()

        NSLayoutConstraint.activate([
            imageDisplayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            imageDisplayView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            imageDisplayView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            imageDisplayView.bottomAnchor.constraint(equalTo: memeToolbar.topAnchor, constant: 0.0)
        ])
        
        NSLayoutConstraint.activate([
            topTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 30.0),
            topTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25.0),
            topTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0),
            topTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0),
        ])
        
        NSLayoutConstraint.activate([
            bottomTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 30.0),
            bottomTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0),
            bottomTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0),
            bottomTextField.bottomAnchor.constraint(equalTo: memeToolbar.topAnchor, constant: -25.0)
        ])
        
        NSLayoutConstraint.activate([
            memeToolbar.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0.0),
            memeToolbar.heightAnchor.constraint(equalToConstant: 50.0),
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
    @objc func didPressSaveButton() {
        let memedImage: UIImage = generateMemedImage()
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageDisplayView.image!, memedImage: memedImage)

        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
        print("\(meme.topText) \(meme.bottomText) saved to storage...")
    }
    
    @objc func didSelectImagePickerButton(_ sender: UIBarButtonItem) {
        guard let buttonTitle = sender.title else { return }
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        if buttonTitle == "Gallery" {
            imagePicker.sourceType = .photoLibrary
        }
        if buttonTitle == "Camera" {
            imagePicker.sourceType = .camera
        }
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
        self.present(activityViewController, animated: true)
        activityViewController.completionWithItemsHandler = {(activity, completed, items, error) in
            if (completed) {
                self.didPressSaveButton()
                self.dismiss(animated:true,completion:nil)
            }
        }
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
            updateMemeMeTextFields(topTextField, "TOP TEXT HERE...", centerAttributedText)
            
            // Re-initialised Bottom Text Field
            updateMemeMeTextFields(bottomTextField, "BOTTOM TEXT HERE...", centerAttributedText)
            
            // Enable Save Button
            memeToolbarSaveButton.isEnabled = true
            
            // Enable Share Button
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: memeNavigationShareButton)
            memeNavigationShareButton.addTarget(self, action: #selector(didPressShareButton), for: .touchUpInside)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func updateMemeMeTextFields(_ uiTextField: UITextField, _ placeHolderString: String, _ centerAttributedText: NSMutableParagraphStyle) {
        uiTextField.isHidden = false
        uiTextField.defaultTextAttributes = memeTextAttributes
        uiTextField.attributedText = NSAttributedString(string: placeHolderString, attributes: [.paragraphStyle: centerAttributedText])
    }

    func imagePickerControllerDidCancel(_: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // MARK: NotificationCenter for Keyboard
    @objc func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notifcation: Notification) -> CGFloat {
        let userInfo = notifcation.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    
    
    // MARK: Saving Meme    
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
class MemeMeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
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

