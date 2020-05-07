//
//  User.swift
//  SkovTwitter
//
//  Created by Oleksandr Kovalyshyn on 07.05.2020.
//  Copyright © 2020 Oleksandr Kovalyshyn. All rights reserved.
//

import Foundation

struct User {
    let fullName: String
    let email: String
    let username: String
    var profileImageURL: URL?
    let uid: String
    
    init(uid: String ,dictionary: [String: AnyObject]) {
        self.uid = uid
        
        self.fullName = dictionary["fullName"] as? String ?? "N/A"
        self.email = dictionary["email"] as? String ?? "N/A"
        self.username = dictionary["username"] as? String ?? "N/A"
        
        if let profileImageURLString = dictionary["profileImageURL"] as? String {
            guard let url =  URL(string: profileImageURLString) else { return }
            self.profileImageURL = url
        }
    }
}
