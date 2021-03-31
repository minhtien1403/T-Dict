//
//  String.swift
//  T-Dict
//
//  Created by Tiến on 3/29/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import Foundation

extension String {
    var safeString: String {
        return trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "%20")
    }
}
