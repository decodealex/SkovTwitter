//
//  ProfileHeaderViewModel.swift
//  SkovTwitter
//
//  Created by Oleksandr Kovalyshyn on 13.05.2020.
//  Copyright © 2020 Oleksandr Kovalyshyn. All rights reserved.
//

import UIKit

enum ProfileFilterOptions: Int, CaseIterable {
    case tweets
    case replies
    case likes
    
    var description: String {
        switch self {
        case .tweets:
            return "Tweets"
        case .replies:
            return "Tweet's & Replies"
        case .likes:
            return "Likes"
        }
    }
}

struct ProfileHeaderViewModel {
    
    // MARK: - Properties
    
    private let user: User
    
    var followersString: NSAttributedString? {
        return attributedText(withValue: user.stats?.followers ?? 0, text: "followers")
    }
    
    var followingString: NSAttributedString? {
        return attributedText(withValue: user.stats?.following ?? 0, text: "following")
    }
    
    var actionButtonTitle: String {
        if user.isCurrentUser {
            return "Edit Profile"
        }
        
        if !user.isFollowed && !user.isCurrentUser {
            return "Follow"
        }
        
        if user.isFollowed {
            return "Following"
        }
        
        return "Loading.."
    }
    
    let usernameText: String
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        
        self.usernameText = "@\(user.username)"
    }
    
    // MARK: - Helpers
    
    private func attributedText(withValue value: Int, text: String) -> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(string: "\(value)", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedTitle.append(NSAttributedString(string: " \(text)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        
        return attributedTitle
    }
}
