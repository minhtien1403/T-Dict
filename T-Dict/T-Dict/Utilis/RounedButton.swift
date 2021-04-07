//
//  RounedButton.swift
//  T-Dict
//
//  Created by Tiến on 4/7/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
final class  RounedButton: UIButton {
    
    private var _cornerRadius: CGFloat = 0
    
    @IBInspectable
    var cornerRadius: CGFloat {
        set (newValue) {
            _cornerRadius = newValue
            layer.cornerRadius = _cornerRadius
        }
        get {
            return _cornerRadius
        }
    }
}
