//
//  TweetViewModel.swift
//  SkovTwitter
//
//  Created by Oleksandr Kovalyshyn on 08.05.2020.
//  Copyright © 2020 Oleksandr Kovalyshyn. All rights reserved.
//

import UIKit

struct TweetViewModel {
    
    let tweet: Tweet
    let user: User
    
    var profileImageURL: URL? { return tweet.user.profileImageURL }
    var timestamp: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: tweet.timestamp, to: now) ?? ""
    }
    
    var userInfoText: NSAttributedString {
        let title = NSMutableAttributedString(string: user.fullName, attributes: [.font: UIFont.boldSystemFont(ofSize: 15) ])
        title.append(NSAttributedString(string: " @\(user.username) ・\(timestamp)", attributes: [.font: UIFont.systemFont(ofSize: 15),
                                                                                   .foregroundColor: UIColor.lightGray]))
        
        return title
    }
    
    init(tweet: Tweet, user: User) {
        self.tweet = tweet
        self.user = user
    }
}
