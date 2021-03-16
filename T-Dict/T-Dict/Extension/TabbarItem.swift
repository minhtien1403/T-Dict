//
//  TabbarItem.swift
//  T-Dict
//
//  Created by Tiến on 3/17/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import Foundation
import UIKit

enum TabbarItem {
    
    case search
    case list
    case utilities
    
    var item: UITabBarItem {
        switch self {
        case .search:
            return UITabBarItem(title: "Search",
                                image: UIImage(named: "ic-search"),
                                selectedImage: nil)
        case .list:
            return UITabBarItem(title: "List",
                                image: UIImage(named: "ic-list"),
                                selectedImage: nil)
        case .utilities:
            return UITabBarItem(title: "Utilities",
                                image: UIImage(named: "ic-utilities"),
                                selectedImage: nil)
        }
    }
}
