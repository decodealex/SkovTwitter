//
//  EditProfileFooter.swift
//  SkovTwitter
//
//  Created by Oleksandr Kovalyshyn on 19.07.2020.
//  Copyright © 2020 Oleksandr Kovalyshyn. All rights reserved.
//

import UIKit

protocol EditProfileFooterDelegate: class {
    func handleLogoutTapped()
}

class EditProfileFooter: UIView {
    
    // MARK: - Properties
    
    weak var delegate: EditProfileFooterDelegate?
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(logoutButton)
        logoutButton.center(inView: self)
        logoutButton.addConstraintsToFillView(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Selectors
    
    @objc func handleLogout() {
        delegate?.handleLogoutTapped()
    }
}
