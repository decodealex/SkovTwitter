//
//  RegistrationController.swift
//  SkovTwitter
//
//  Created by Oleksandr Kovalyshyn on 11.04.2020.
//  Copyright © 2020 Oleksandr Kovalyshyn. All rights reserved.
//


import UIKit
import Firebase

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
    
    private let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode  = .scaleAspectFit
        button.addTarget(self, action: #selector(handleAddPhotoButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = Utilities.inputContainerView(withImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), textfield: self.emailTextfield)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = Utilities.inputContainerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textfield: self.passwordTextfield)
        return view
    }()
    
    private let emailTextfield: UITextField = {
        let tf = Utilities.textField(withPlaceholder: "Email")
        return tf
    }()
    
    private let passwordTextfield: UITextField = {
        let tf = Utilities.textField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var fullNameContainerView: UIView = {
        let view = Utilities.inputContainerView(withImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textfield: self.fullNameTextfield)
        return view
    }()
    
    private lazy var usernameContainerView: UIView = {
        let view = Utilities.inputContainerView(withImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textfield: self.userNameTextfield)
        return view
    }()
    
    private let fullNameTextfield: UITextField = {
        let tf = Utilities.textField(withPlaceholder: "Full Name")
        return tf
    }()
    
    private let userNameTextfield: UITextField = {
        let tf = Utilities.textField(withPlaceholder: "Username")
        return tf
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(hadleSignUp), for: .touchUpInside)
        
        return button
    }()
    
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = Utilities.attributedButton("Already have an account? ", "Log In")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleAddPhotoButton() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func hadleSignUp() {
        guard let email = emailTextfield.text, !email.isEmpty else {
            print("❗️DEBUG: Email cant be empty")
            return
        }
        guard let password = passwordTextfield.text, !password.isEmpty else {
            print("❗️DEBUG: passwordTextfield cant be empty")
            return
        }
        guard let fullName = fullNameTextfield.text, !fullName.isEmpty else {
            print("❗️DEBUG: fullNameTextfield cant be empty")
            return
        }
        guard let username = userNameTextfield.text?.lowercased(), !username.isEmpty else {
            print("❗️DEBUG: userNameTextfield cant be empty")
            return
        }
        guard let profileImage = profileImage else {
            print("❗️DEBUG: profileImage cant be empty")
            return
        }
        
        let credentials = AuthCredentials(email: email, password: password, fullName: fullName,
                                          username: username, profileImage: profileImage)
        
        AuthService.shared.registerUser(credentials: credentials) { (error, ref) in
            print("✅ DEBUG: SignUp successful")
            
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow}) else { return }
            
            guard let tab = window.rootViewController as? MainTabBarController else { return }
            tab.authenticateUserAndConfigureUI()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        
        configureAlreadyHaveAccountButton()
        configureAddPhotoButton()
        configureStackView()
        configureImagePicker()
    }
    
    private func configureStackView() {
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView,
                                                   fullNameContainerView,
                                                   usernameContainerView,
                                                   signUpButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: addPhotoButton.bottomAnchor, left: view.leftAnchor,
                     right: view.rightAnchor, paddingLeft: 20, paddingRight: 20)
    }
    
    private func configureAlreadyHaveAccountButton() {
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                        right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
    }
    
    private func configureAddPhotoButton() {
        view.addSubview(addPhotoButton)
        addPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        addPhotoButton.setDimensions(width: 128, height: 128)
    }
    
    private func configureImagePicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
}

// MARK: - UIImagePickerControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.profileImage = profileImage
        
        addPhotoButton.layer.cornerRadius = 128 / 2
        addPhotoButton.layer.masksToBounds = true
        addPhotoButton.imageView?.contentMode = .scaleAspectFill
        addPhotoButton.imageView?.clipsToBounds = true
        addPhotoButton.layer.borderColor = UIColor.white.cgColor
        addPhotoButton.layer.borderWidth = 3
        
        self.addPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
}

