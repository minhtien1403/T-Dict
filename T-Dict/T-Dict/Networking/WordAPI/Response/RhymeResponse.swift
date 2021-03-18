//
//  RhymeResponse.swift
//  T-Dict
//
//  Created by Tiến on 3/18/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import Foundation

struct RhymeResponse: Codable {
    let word: String?
    let rhymes: Rhyme?
}

struct Rhyme: Codable {
    let all: [String]?
}
