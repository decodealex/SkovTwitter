//
//  ExploreController.swift
//  SkovTwitter
//
//  Created by Oleksandr Kovalyshyn on 08.04.2020.
//  Copyright © 2020 Oleksandr Kovalyshyn. All rights reserved.
//

import UIKit

class ExploreController: UIViewController {

 
    // MARK: - Properties

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        navigationItem.title = "Explore"
    }

}
