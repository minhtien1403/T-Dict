//
//  URLs.swift
//  T-Dict
//
//  Created by Tiến on 3/18/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import Foundation

struct URLs {
    
    private static var APIBaseUrl = "https://wordsapiv1.p.rapidapi.com"
    
    public static let APIGetUrl = APIBaseUrl + "/words"
    static let GetRandomWordURL = "https://wordsapiv1.p.rapidapi.com/words/?random=true"
    static var QuizBaseURL = "https://twinword-word-association-quiz.p.rapidapi.com/type1/?level=%d&area=toeic"
}
