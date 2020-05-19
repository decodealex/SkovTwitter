//
//  NotificationModel.swift
//  SkovTwitter
//
//  Created by Oleksandr Kovalyshyn on 19.05.2020.
//  Copyright © 2020 Oleksandr Kovalyshyn. All rights reserved.
//

import Foundation

enum NotificationType: Int {
    case follow
    case like
    case reply
    case retweet
    case mention
}

struct NotificationModel {
    
    // MARK: - Properties
    
    let tweetID: String?
    var timestamp: Date!
    let user: User
    var tweet: Tweet?
    var type: NotificationType!
    
    // MARK: - Lifecycle
    
    init(user: User, dictionary: [String: AnyObject]) {
        self.user = user
        
        self.tweetID = dictionary["tweetID"] as? String ?? ""
        
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
        
        if let type = dictionary["type"] as? Int {
            self.type = NotificationType(rawValue: type)
        }
    }
    
    // MARK: - API
    
    // MARK: - Selectors
    
    // MARK: - Helpers
}