//
//  NotificationViewModel.swift
//  SkovTwitter
//
//  Created by Oleksandr Kovalyshyn on 19.05.2020.
//  Copyright © 2020 Oleksandr Kovalyshyn. All rights reserved.
//

import UIKit

struct NotificationViewModel {
    
    // MARK: - Properties
    
    private let notification: NotificationModel
    private let type: NotificationType
    private let user: User
    
    var timestamp: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: notification.timestamp, to: now) ?? ""
    }
    
    private var notificationMessage: String {
        switch type {
        case .follow: return " started following you"
        case .like: return " liked your tweet"
        case .reply: return " replied to your tweet"
        case .retweet: return " retweeted your tweet"
        case .mention: return " mentioned you in tweet"
        }
    }
    
    var notificationText: NSAttributedString? {
        guard let timestamp = timestamp else { return nil }
    
        let title = NSMutableAttributedString(string: "@\(user.username)", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
        
        title.append(NSAttributedString(string: notificationMessage, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]))
        title.append(NSAttributedString(string: " \(timestamp)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        
        return title
    }
    
    var profileImageURL: URL? {
        return user.profileImageURL
    }
    
    // MARK: - Lifecycle
    
    init(notification: NotificationModel) {
        self.notification = notification
        self.type = notification.type
        self.user = notification.user
    }
    
    // MARK: - API
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
}
