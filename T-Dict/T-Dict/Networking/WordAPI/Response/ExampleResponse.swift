//
//  exampleResponse.swift
//  T-Dict
//
//  Created by Tiến on 3/18/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import Foundation

struct ExampleResponse: Codable  {
    let word: String?
    let examples: [String]?
}
