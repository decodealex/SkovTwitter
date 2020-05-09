//
//  LoginController.swift
//  SkovTwitter
//
//  Created by Oleksandr Kovalyshyn on 11.04.2020.
//  Copyright © 2020 Oleksandr Kovalyshyn. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: - Properties
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "TwitterLogo")
        return iv
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
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(hadleLogin), for: .touchUpInside)
        
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = Utilities.attributedButton("Don't have an account? ", "Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func hadleLogin() {
        guard let email = emailTextfield.text, !email.isEmpty else {
            print("❗️DEBUG: Email cant be empty")
            return
        }
        guard let password = passwordTextfield.text, !password.isEmpty else {
            print("❗️DEBUG: passwordTextfield cant be empty")
            return
        }
        
        AuthService.shared.logUserIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("❗️DEBUG: Cant log in error is \(error.localizedDescription)")
                return
            }
            print("✅ DEBUG: LogIn successful")
            
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow}) else { return }
            
            guard let tab = window.rootViewController as? MainTabBarController else { return }
            tab.authenticateUserAndConfigureUI()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleShowSignUp() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        
        configureNavigationController()
        configureLogoImageView()
        configureStackView()
        configureDontHaveAccountButton()
    }
    
    private func configureStackView() {
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView,
                                                   loginButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor,
                     right: view.rightAnchor, paddingLeft: 20, paddingRight: 20)
    }
    
    private func configureNavigationController() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150, height: 150)
    }
    
    func configureDontHaveAccountButton() {
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
    }
    
}
