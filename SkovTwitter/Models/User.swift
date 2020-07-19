//
//  User.swift
//  SkovTwitter
//
//  Created by Oleksandr Kovalyshyn on 07.05.2020.
//  Copyright © 2020 Oleksandr Kovalyshyn. All rights reserved.
//

import Foundation
import Firebase

struct User {
    
    // MARK: - Properties
    
    let fullName: String
    let email: String
    let username: String
    var profileImageURL: URL?
    let uid: String
    var isFollowed = false
    var stats: UserRelationStats?
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == uid }
    
    // MARK: - Lifecycle
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        
        self.fullName = dictionary["fullName"] as? String ?? "N/A"
        self.email = dictionary["email"] as? String ?? "N/A"
        self.username = dictionary["username"] as? String ?? "N/A"
        
        if let profileImageURLString = dictionary["profileImageURL"] as? String {
            guard let url = URL(string: profileImageURLString) else { return }
            self.profileImageURL = url
        }
    }
    
    // MARK: - API
    
    // MARK: - Selectors
    
    // MARK: - Helpers

}

struct UserRelationStats {
    var followers: Int
    var following: Int
}
