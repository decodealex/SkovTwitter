//
//  NotificationsController.swift
//  SkovTwitter
//
//  Created by Oleksandr Kovalyshyn on 08.04.2020.
//  Copyright © 2020 Oleksandr Kovalyshyn. All rights reserved.
//

import UIKit

private let cellReuseIdentifier = "cellReuseIdentifier"

class NotificationsController: UITableViewController {

   
    // MARK: - Properties
    
    private var notifications = [NotificationModel]() {
        didSet { tableView.reloadData() }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchNotifications()
        configureUI()
    }
    
    // MARK: - API
    
    func fetchNotifications() {
        NotificationService.shared.fetchNotifications { notifications in
            self.notifications = notifications
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Notifications"
        
        tableView.register(NotificationCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
    }

}

extension NotificationsController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! NotificationCell
        cell.notification = notifications[indexPath.row]
        return cell
    }
}
