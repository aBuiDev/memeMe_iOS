//
//  MemeMeSentMemesTableViewController.swift
//  memeMe_iOS
//
//  Created by Andrew Bui on 11/9/21.
//

import Foundation
import UIKit

class MemeMeSentMemesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var forCellWithReuseIdentifier = "memeTableCell"
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    lazy var createMemeButton: UIBarButtonItem = {
        let uiBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus.square"),
            style: .plain,
            target: self,
            action: #selector(didPressCreateMemeButton(_:))
        )
        return uiBarButtonItem
    }()
    
    private var memeMeTableView: UITableView = {
        let uiTableView = UITableView(frame: .zero)
        uiTableView.translatesAutoresizingMaskIntoConstraints = false
        uiTableView.separatorColor = .white
        return uiTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        title = "Table Gallery"
        
        memeMeTableView.delegate = self
        memeMeTableView.dataSource = self
        memeMeTableView.register(MemeMeTableViewCell.self, forCellReuseIdentifier: MemeMeTableViewCell.identifier)

        navigationItem.rightBarButtonItem = createMemeButton
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        view.addSubview(memeMeTableView)
        
        NSLayoutConstraint.activate([
            memeMeTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            memeMeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            memeMeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            memeMeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0)
        ])

    }
    
    @objc func didPressCreateMemeButton(_ sender: UIBarButtonItem) {
        let memeMeMainViewController = MemeMeMainViewController()
        navigationController?.present(memeMeMainViewController, animated: true, completion: nil)
    }
    
    
    // TableView Delegate Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = memeMeTableView.dequeueReusableCell(withIdentifier: MemeMeTableViewCell.identifier, for: indexPath) as! MemeMeTableViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]

        tableViewCell.memeImage.image = meme.originalImage
        tableViewCell.topMemeText.text = meme.topText
        tableViewCell.bottomMemeText.text = meme.bottomText
        
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meme = self.memes[(indexPath as NSIndexPath).row]
        let memeMeMemeDetailsViewController = MemeMeMemeDetailsViewController(memeDetails: meme)
        self.navigationController?.present(memeMeMemeDetailsViewController, animated: true, completion: nil)
    }
}


class MemeMeTableViewCell: UITableViewCell {
    static let identifier = "MemeMeTableViewCellIdentifier"
    
    lazy var topMemeText: UILabel = {
        generateLabel()
    }()
    
    lazy var bottomMemeText: UILabel = {
        generateLabel()
    }()
    
    private func generateLabel() -> UILabel {
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        uiLabel.textAlignment = .center
        uiLabel.textColor = .white
        uiLabel.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 20)
        uiLabel.numberOfLines = 0
        return uiLabel
    }
    
    private let memeTableViewCellStackView: UIStackView = {
        let uiStackView = UIStackView()
        uiStackView.translatesAutoresizingMaskIntoConstraints = false
        uiStackView.alignment = .center
        uiStackView.axis = .vertical
        uiStackView.distribution = .fillEqually
        return uiStackView
    }()
    
    var memeImage: UIImageView = {
        let uiImage = UIImageView()
        uiImage.translatesAutoresizingMaskIntoConstraints = false
        uiImage.contentMode = .scaleAspectFill
        uiImage.clipsToBounds = true
        return uiImage
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        contentView.addSubview(memeImage)
        memeTableViewCellStackView.addArrangedSubview(topMemeText)
        memeTableViewCellStackView.addArrangedSubview(bottomMemeText)
        contentView.addSubview(memeTableViewCellStackView)

        NSLayoutConstraint.activate([
            memeImage.widthAnchor.constraint(equalToConstant: 150),
            memeImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            memeImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0),
            memeImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0)
        ])
        
        NSLayoutConstraint.activate([
            memeTableViewCellStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.0),
            memeTableViewCellStackView.leadingAnchor.constraint(equalTo: memeImage.trailingAnchor, constant: 5.0),
            memeTableViewCellStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5.0),
            memeTableViewCellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15.0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
