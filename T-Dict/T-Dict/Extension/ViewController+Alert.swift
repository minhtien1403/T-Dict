//
//  ViewController+Alert.swift
//  T-Dict
//
//  Created by Tiến on 4/2/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func alertError(message: String) {
        let alert = UIAlertController(title: "Something wrong",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel,
                                      handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
