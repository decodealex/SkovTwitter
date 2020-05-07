//
//  MainTabBarController.swift
//  SkovTwitter
//
//  Created by Oleksandr Kovalyshyn on 08.04.2020.
//  Copyright © 2020 Oleksandr Kovalyshyn. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {

    //MARK: - Properties
    
    var user: User? {
        didSet {
            guard let nav = viewControllers?[0] as? UINavigationController else { return }
            guard let feed = nav.viewControllers.first as? FeedController else { return }
            feed.user = user
        }
    }
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .twitterBlue
        authenticateUserAndConfigureUI()
    }
    
    //MARK: - API
    
    func fetchUser() {
        UserService.shared.fetchUser { user in
            self.user = user
        }
    }
    
    func authenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            print("❗️DEBUG: User is not log in")
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            print("✅ DEBUG: User is log in")
            configureViewControllers()
            configureUI()
            fetchUser()
        }
    }
    
    func logUserOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("❗️DEBUG: Failed to signOut with error \(error.localizedDescription)")
        }
    }
    
    //MARK: - Selectors
    
    @objc func actionButtonTapped() {
        guard let user = user else { return }
        let controller = UploadTweetController(user: user)
        let nav = UINavigationController(rootViewController: controller)
        present(nav, animated: true, completion: nil)
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56 / 2
    }
    
    func configureViewControllers() {
        
        let feedVC = FeedController()
        let feedNavigationController = templateNavigationController(rootViewController: feedVC, image: UIImage(named: "home_unselected")!, title: "")
        
        let exploreVC = ExploreController()
        let exploreNavigationController = templateNavigationController(rootViewController: exploreVC, image: UIImage(named: "search_unselected")!, title: "")
        
        let notificationVC = NotificationsController()
        let notificationNavigationController = templateNavigationController(rootViewController: notificationVC, image: UIImage(named: "like_unselected")!, title: "")
        
        let conversationsVC = ConversationsController()
        let conversationsNavigationController = templateNavigationController(rootViewController: conversationsVC, image: UIImage(named: "ic_mail_outline_white_2x-1")!, title: " ")
        
        viewControllers = [feedNavigationController, exploreNavigationController, notificationNavigationController, conversationsNavigationController]
    }
    
    func templateNavigationController(rootViewController: UIViewController, image: UIImage, title: String) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: image)
        nav.navigationBar.barTintColor = .white
        view.backgroundColor = .white
        return nav
    }

}
