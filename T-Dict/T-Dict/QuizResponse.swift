//
//  QuizResponse.swift
//  T-Dict
//
//  Created by Tiến on 4/11/21.
//  Copyright © 2021 Tiến. All rights reserved.
//
import Foundation
 
struct Quiz: Codable {
    let quiz: [String]?
    let option: [String]?
    let correct: Int?
}
 
struct QuizResponse: Codable {
    let quizlist: [Quiz]?
    let result_code: String?
    let result_msg: String?
}

