//
//  EditProfileController.swift
//  SkovTwitter
//
//  Created by Oleksandr Kovalyshyn on 20.05.2020.
//  Copyright © 2020 Oleksandr Kovalyshyn. All rights reserved.
//

import UIKit

private let cellReuseIdentifier = "cellReuseIdentifier"

protocol EditProfileControllerDelegate: class {
    func handleLogout()
}

class EditProfileController: UITableViewController {
    
    // MARK: - Properties
    
    private let user: User
    private lazy var headerView = EditProfileHeader(user: user)
    private let footerView = EditProfileFooter()
    private let imagePicker = UIImagePickerController()
    weak var delegate: EditProfileControllerDelegate?
    
    private var userInfoChanged: Bool {
        true
    }
    
    private var imageChanged: Bool {
        selectedImage != nil
    }
    
    private var selectedImage: UIImage? {
        didSet { headerView.profileImageView.image = selectedImage }
    }
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureTableView()
        configureImagePicker()
    }
    
    // MARK: - API
    
    func updateUserData() {
        if imageChanged && !userInfoChanged {
            print("❗️DEBUG: Changed image and not data")
            updateProfileImage()
        }
        
        if !imageChanged && userInfoChanged {
            print("❗️DEBUG: Changed data and not image")
            //            UserService.shared.saveUserData
        }
        
        if imageChanged && userInfoChanged {
            print("❗️DEBUG: Changed data and image")
            //            UserService.shared.saveUserData
        }
    }
    
    func updateProfileImage() {
        guard let image = selectedImage else { return }
        
        //        UserService.shared.updateProfileImage
    }
    
    // MARK: - Selectors
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleDone() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.title = "Edit Profile"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: #selector(handleDone))
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    func configureTableView() {
        tableView.tableHeaderView = headerView
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 180)
        footerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        tableView.tableFooterView = footerView
        
        footerView.delegate = self
        headerView.delegate = self
        
        tableView.register(EditProfileCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func configureImagePicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
}

extension EditProfileController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EditProfileOptions.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! EditProfileCell
        
        return cell
    }
}

extension EditProfileController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let option = EditProfileOptions(rawValue: indexPath.row) else { return 0 }
        
        return option == .bio ? 100 : 48
    }
}

//MARK: - EditProfileHeaderDelegate
extension EditProfileController: EditProfileHeaderDelegate {
    func didTapChangeProfilePhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
}

//MARK: - EditProfileController
extension EditProfileController: EditProfileFooterDelegate {
    func handleLogoutTapped() {
        let alert = UIAlertController(title: nil, message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { [weak self] _ in
            guard let self = self else { return }
            print("❗️DEBUG: logout yes")
            self.dismiss(animated: true) {
                self.delegate?.handleLogout()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension EditProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        self.selectedImage = image
        
        dismiss(animated: true, completion: nil)
    }
}
