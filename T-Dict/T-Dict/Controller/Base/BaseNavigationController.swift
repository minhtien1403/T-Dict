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
        delegate = self
    }
}

extension BaseNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        let item = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        viewController.navigationItem.backBarButtonItem = item
        viewController.navigationItem.backBarButtonItem?.tintColor = .white
        viewController.navigationItem.rightBarButtonItem?.tintColor = .white
    }
}
