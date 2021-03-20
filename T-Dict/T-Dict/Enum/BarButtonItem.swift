//
//  BarButtonItem.swift
//  T-Dict
//
//  Created by Tiến on 3/21/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import Foundation
import UIKit

enum BarButtonItem {
    case favoriteOn
    case favoriteOff
    
    var item: UIBarButtonItem {
        switch self {
        case .favoriteOn:
            return UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: nil)
        case .favoriteOff:
            return UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: nil)
        }
    }
}
