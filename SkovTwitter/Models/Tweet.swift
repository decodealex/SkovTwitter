//
//  Tweet.swift
//  SkovTwitter
//
//  Created by Oleksandr Kovalyshyn on 08.05.2020.
//  Copyright © 2020 Oleksandr Kovalyshyn. All rights reserved.
//

import Foundation

struct Tweet {
    
    let caption: String
    let tweetID: String
    let uid: String
    let likes: Int
    var timestamp: Date!
    let retweetCount: Int
    let user: User
    
    init(user: User, tweetID: String, dictionary: [String: Any]) {
        self.tweetID = tweetID
        self.user = user
        
        self.caption = dictionary["caption"] as? String ?? "N/A"
        self.uid = dictionary["uid"] as? String ?? "N/A"
        self.likes = dictionary["likes"] as? Int ?? 0
        self.retweetCount = dictionary["retweetCount"] as? Int ?? 0
        
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }

    }
    
}
