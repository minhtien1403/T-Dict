//
//  Array+.swift
//  T-Dict
//
//  Created by Tiến on 4/11/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import Foundation

extension Array {
    public subscript(index: Int, default defaultValue: @autoclosure () -> Element) -> Element {
        guard index >= 0, index < endIndex else {
            return defaultValue()
        }
        return self[index]
    }
}
