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
    
    func fetchUser() {
        print("✅ DEBUG: Fetch current user")
        guard let uid = Auth.auth().currentUser?.uid else { return }
        print("✅ DEBUG: Current user uid = \(uid)")
        
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            print("✅ DEBUG: Snapshot = \(snapshot)")
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            print("✅ DEBUG: Dictionary = \(dictionary)")

        }
    }
}
