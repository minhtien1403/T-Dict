//
//  BaseNavi.swift
//  T-Dict
//
//  Created by Tiến on 3/16/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = UIColor.FE2200
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                  NSAttributedString.Key.font: UIFont.breeSerif(24)]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configBarButton()
    }
    
    func configBarButton() {
        self.viewControllers.first?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        self.viewControllers.first?.navigationItem.backBarButtonItem?.tintColor = .white
    }
}
