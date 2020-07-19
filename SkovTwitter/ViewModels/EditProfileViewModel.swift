//
//  EditProfileViewModel.swift
//  SkovTwitter
//
//  Created by Oleksandr Kovalyshyn on 20.05.2020.
//  Copyright © 2020 Oleksandr Kovalyshyn. All rights reserved.
//

import Foundation

enum EditProfileOptions: Int, CaseIterable {
    case fullName
    case username
    case bio
    
    var description: String {
        switch self {
        case .fullName:
            return "Name"
        case .username:
            return "Username"
        case .bio:
            return "Bio"
        }
    }
}

struct EditProfileViewModel {
    
}
