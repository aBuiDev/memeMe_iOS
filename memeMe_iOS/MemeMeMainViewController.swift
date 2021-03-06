//
//  ViewController.swift
//  memeMe_iOS
//
//  Created by Andrew Bui on 29/8/21.
//

import UIKit

class MemeMeMainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // MARK: Initialise Delegates
    let topTextFieldDelegate = MemeMeTextFieldDelegate()
    let bottomTextFieldDelegate = MemeMeTextFieldDelegate()
    
    /// MemeText Attributes
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor.black,
        .foregroundColor: UIColor.white,
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        .strokeWidth: -3.0
    ]
    
    
    
    // MARK: MemeMe Image View
    private var imageDisplayView: UIImageView = {
        let uiImageView = UIImageView()
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        uiImageView.contentMode = .scaleAspectFit
        uiImageView.clipsToBounds = true
        return uiImageView
    }()
    
    
    
    // MARK: MemeMe Top Toolbar
    private var memeTopToolbar: UIToolbar = {
        let uiToolbar = UIToolbar()
        uiToolbar.translatesAutoresizingMaskIntoConstraints = false
        uiToolbar.barTintColor = .black
        uiToolbar.sizeToFit()
        return uiToolbar
    }()
    
    /// Toolbar Buttons
    private lazy var memeCreateTopToolbarCancelButton: UIButton = {
        createMemeMeToolbarBarButton(imageName: "xmark", isEnabled: true)
    }()
    
    private lazy var memeCreateTopToolbarShareButton: UIButton = {
        createMemeMeToolbarBarButton(imageName: "square.and.arrow.up", isEnabled: false)
    }()
    
    /// Toolbar Button Creator
    private func createMemeMeToolbarBarButton(imageName: String, isEnabled: Bool) -> UIButton {
        let uiButton = UIButton()
        uiButton.translatesAutoresizingMaskIntoConstraints = false
        uiButton.setImage(UIImage(systemName: imageName), for: .normal)
        uiButton.tintColor = .white
        uiButton.isEnabled = isEnabled
        return uiButton
    }
    
    /// Toolbar Title
    private var memeMeCreateTitleLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.text = "Create Meme"
        uiLabel.textColor = .white
        return uiLabel
    }()
    
    
    
    // MARK: MemeMe Toolbar
    private var memeToolbar: UIToolbar = {
        let uiToolbar = UIToolbar()
        uiToolbar.translatesAutoresizingMaskIntoConstraints = false
        uiToolbar.barTintColor = .black
        uiToolbar.sizeToFit()
        return uiToolbar
    }()
    
    private lazy var memeToolbarImagePickerButton: UIBarButtonItem = {
        createToolBarButtons(image: "photo.on.rectangle", isEnabled: true)
    }()

    private lazy var memeToolbarSaveButton: UIBarButtonItem = {
        createToolBarButtons(image: "square.and.arrow.down.on.square", isEnabled: false)
    }()
    
    private lazy var memeToolbarCameraButton: UIBarButtonItem = {
        createToolBarButtons(image: "camera", isEnabled: UIImagePickerController.isSourceTypeAvailable(.camera))
    }()
    
    func createToolBarButtons(image: String, isEnabled: Bool) -> UIBarButtonItem {
        let uiBarButtonItem = UIBarButtonItem()
        uiBarButtonItem.image = UIImage(systemName: image)
        uiBarButtonItem.style = .plain
        uiBarButtonItem.target = self
        uiBarButtonItem.tintColor = .white
        uiBarButtonItem.isEnabled = isEnabled
        return uiBarButtonItem
    }
    
    private let memeToolbarFlexibleSpacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)



    // MARK: Text Fields
    private lazy var topTextField: UITextField = {
        generateTextField()
    }()
    
    private lazy var bottomTextField: UITextField = {
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
        
        memeToolbarImagePickerButton.action = #selector(didSelectImagePickerButton(_ :))
        memeToolbarSaveButton.action = #selector(didPressSaveButton)
        memeToolbarCameraButton.action = #selector(didSelectImagePickerButton(_ :))
        memeCreateTopToolbarCancelButton.addTarget(self, action: #selector(didPressCancelCreateMemeButton), for: .touchUpInside)
        
        // Delegates
        topTextField.delegate = topTextFieldDelegate
        bottomTextField.delegate = bottomTextFieldDelegate
        
        view.backgroundColor = .black
        
        // Body
        view.addSubview(imageDisplayView)
        view.addSubview(topTextField)
        view.addSubview(bottomTextField)
        
        // Top Toolbar
        view.addSubview(memeTopToolbar)
        memeTopToolbar.addSubview(memeCreateTopToolbarShareButton)
        memeTopToolbar.addSubview(memeMeCreateTitleLabel)
        memeTopToolbar.addSubview(memeCreateTopToolbarCancelButton)
        
        // Bottom Toolbar
        view.addSubview(memeToolbar)
        memeToolbar.items = setupToolbarItems()
        
        // Constraints: Top Toolbar
        NSLayoutConstraint.activate([
            memeTopToolbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            memeTopToolbar.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0.0),
            memeTopToolbar.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        
        NSLayoutConstraint.activate([
            memeCreateTopToolbarShareButton.centerYAnchor.constraint(equalTo: memeTopToolbar.centerYAnchor),
            memeCreateTopToolbarShareButton.leadingAnchor.constraint(equalTo: memeTopToolbar.leadingAnchor, constant: 25.0),
        ])
        
        NSLayoutConstraint.activate([
            memeMeCreateTitleLabel.centerYAnchor.constraint(equalTo: memeTopToolbar.centerYAnchor),
            memeMeCreateTitleLabel.centerXAnchor.constraint(equalTo: memeTopToolbar.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            memeCreateTopToolbarCancelButton.centerYAnchor.constraint(equalTo: memeTopToolbar.centerYAnchor),
            memeCreateTopToolbarCancelButton.trailingAnchor.constraint(equalTo: memeTopToolbar.trailingAnchor, constant: -25.0),
        ])
        
        // Constraints: Body
        NSLayoutConstraint.activate([
            imageDisplayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            imageDisplayView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            imageDisplayView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            imageDisplayView.bottomAnchor.constraint(equalTo: memeToolbar.topAnchor, constant: 0.0)
        ])
        
        NSLayoutConstraint.activate([
            topTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 30.0),
            topTextField.topAnchor.constraint(equalTo: memeTopToolbar.bottomAnchor, constant: 25.0),
            topTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0),
            topTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0),
        ])
        
        NSLayoutConstraint.activate([
            bottomTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 30.0),
            bottomTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0),
            bottomTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0),
            bottomTextField.bottomAnchor.constraint(equalTo: memeToolbar.topAnchor, constant: -25.0)
        ])
        
        // Constraints Bottom Toolbar
        NSLayoutConstraint.activate([
            memeToolbar.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0.0),
            memeToolbar.heightAnchor.constraint(equalToConstant: 50.0),
            memeToolbar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0)
        ])
    }
    
    /// Notifcation Observers
    override func viewWillAppear(_ animated: Bool) {
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeToKeyboardNotifications()
    }
    
    
    
    // MARK: UI Top Toolbar Methods
    func setupTopToolbarItems() -> [UIBarButtonItem] {
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
    
    /// Did Select Image Picker
    @objc func didSelectImagePickerButton(_ sender: UIBarButtonItem) {
        guard let buttonImage = sender.image else { return }
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        if buttonImage == UIImage(systemName: "photo.on.rectangle") {
            imagePicker.sourceType = .photoLibrary
        }
        if buttonImage == UIImage(systemName: "camera") {
            imagePicker.sourceType = .camera
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    /// Toolbar Setup Bar Button Item Layout
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
        let memeMeSentMemesCollectionViewController = MemeMeSentMemesCollectionViewController()
        let imageItems: [UIImage] = [savedImage]
        let activityViewController = UIActivityViewController(activityItems: imageItems, applicationActivities: nil)
        self.present(activityViewController, animated: true)
        activityViewController.completionWithItemsHandler = {(activity, completed, items, error) in
            if (completed) {
                self.didPressSaveButton()
                self.dismiss(animated: true, completion: memeMeSentMemesCollectionViewController.setupViews)
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
            memeCreateTopToolbarShareButton.isEnabled = true
            memeCreateTopToolbarShareButton.addTarget(self, action: #selector(didPressShareButton), for: .touchUpInside)
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
    
    /// NotificationCenter Keyboard Observers
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    
    
    // MARK: Saving Meme    
    func generateMemedImage() -> UIImage {

        // Hide Toolbar
        hideAndShowBars(true, true)

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        // Unhide Toobar
        hideAndShowBars(false, false)

        return memedImage
    }
    
    func hideAndShowBars(_ memeTopToolbarIsHidden: Bool, _ memeToolbarIsHidden: Bool) {
        memeTopToolbar.isHidden = memeTopToolbarIsHidden
        memeToolbar.isHidden = memeToolbarIsHidden
    }
    
    
    
    // MARK: Cancelling Meme Creation
    @objc func didPressCancelCreateMemeButton() {
        let memeMeSentMemesCollectionViewController = MemeMeSentMemesViewController()
        dismiss(animated: true, completion: memeMeSentMemesCollectionViewController.viewDidLoad)
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

