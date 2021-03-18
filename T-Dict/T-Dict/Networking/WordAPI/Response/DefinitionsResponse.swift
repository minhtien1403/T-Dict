//
//  DefinitionsResponse.swift
//  T-Dict
//
//  Created by Tiến on 3/18/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import Foundation

struct DefinitionResponse: Codable {
    let word: String?
    let definitions: [Definitions]?
}

struct Definitions: Codable {
    let definition: String?
    let partOfSpeech: String?
}
