//
//  MainTabBarController.swift
//  SkovTwitter
//
//  Created by Oleksandr Kovalyshyn on 08.04.2020.
//  Copyright © 2020 Oleksandr Kovalyshyn. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    //MARK: - Properties
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewControllers()
        configureUI()
    }
    
    // MARK: - Helpers
    
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
