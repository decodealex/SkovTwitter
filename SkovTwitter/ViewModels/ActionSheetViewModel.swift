//
//  ActionSheetViewModel.swift
//  SkovTwitter
//
//  Created by Oleksandr Kovalyshyn on 18.05.2020.
//  Copyright © 2020 Oleksandr Kovalyshyn. All rights reserved.
//

import UIKit

struct ActionSheetViewModel {
    
    // MARK: - Properties
    
    private let user: User
    
    var option: [ActionSheetOptions] {
        var results = [ActionSheetOptions]()
        
        if user.isCurrentUser {
            results.append(.delete)
        } else {
            let followOption: ActionSheetOptions = user.isFollowed ? .unfollow(user) : .follow(user)
            results.append(followOption)
        }
        
        results.append(.report)
        
        return results
    }
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
    }
}

enum ActionSheetOptions {
    case follow(User), unfollow(User), report, delete
    
    var description: String {
        switch self {
        case .follow(let user):
            return "Follow @\(user.username)"
        case .unfollow(let user):
            return "Unfollow @\(user.username)"
        case .report:
            return "Report Tweet"
        case .delete:
            return "Delete Tweet"
        }
    }
}
