//
//  SuggestRespone.swift
//  T-Dict
//
//  Created by Tiến on 3/28/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import Foundation

struct SuggestResponse: Codable {
    let word: String?
    let also: [String]?
}
