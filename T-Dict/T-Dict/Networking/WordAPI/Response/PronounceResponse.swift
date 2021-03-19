//
//  Pronunciation.swift
//  T-Dict
//
//  Created by Tiến on 3/18/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import Foundation

struct PronounceResponse: Codable {
    let word: String?
    let pronunciation: Pronunciation?
}

struct Pronunciation: Codable {
    let all: String?
}
