//
//  UIFont.swift
//  T-Dict
//
//  Created by Tiến on 3/16/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
      static func breeSerif(_ size: CGFloat) -> UIFont {
        return UIFont(name: "BreeSerif-Regular", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
}
