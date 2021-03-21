//
//  BaseViewController.swift
//  T-Dict
//
//  Created by Tiến on 3/22/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configBarButton()
    }
    
    func configBarButton() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white
    }
}
