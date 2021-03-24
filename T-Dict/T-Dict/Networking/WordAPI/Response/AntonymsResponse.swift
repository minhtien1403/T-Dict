//
//  AntonymsResponse.swift
//  T-Dict
//
//  Created by Tiến on 3/18/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import Foundation

struct AntonymsResponse: Codable {
    let word: String?
    let antonyms: [String]?
}
