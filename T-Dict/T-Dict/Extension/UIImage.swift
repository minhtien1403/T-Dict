//
//  UIImage.swift
//  T-Dict
//
//  Created by Tiến on 3/23/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import UIKit

extension UIImage {
    static let listImage = UIImage(systemName: "text.badge.plus")
    static let addIcon = UIImage(systemName: "plus")
}

enum ListIcon {
    case star
    case tree
    case food
    case car
    
    var icon: UIImage {
        switch self {
        case .star:
            return UIImage(named: "star") ?? UIImage()
        case .tree:
            return UIImage(named: "tree") ?? UIImage()
        case .food:
            return UIImage(named: "food") ?? UIImage()
        case .car:
            return UIImage(named: "car") ?? UIImage()
        }
    }
}
