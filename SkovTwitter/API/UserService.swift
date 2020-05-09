//
//  UserService.swift
//  SkovTwitter
//
//  Created by Oleksandr Kovalyshyn on 07.05.2020.
//  Copyright © 2020 Oleksandr Kovalyshyn. All rights reserved.
//

import UIKit
import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser(uid: String, completion: @escaping(User) -> Void) {
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
        }
    }
}
