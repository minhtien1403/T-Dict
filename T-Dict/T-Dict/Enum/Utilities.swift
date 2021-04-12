//
//  Utilities.swift
//  T-Dict
//
//  Created by Tiến on 4/4/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import Foundation
import UIKit

enum Utilities: String {
    case speech = "Text To Speech"
    case quiz = "Quiz"
    case random = "Get random word"
    case remind = "Remind"
    
    var icon: UIImage {
        switch self {
        case .random:
            return UIImage(named: "dices") ?? UIImage()
        case .remind:
            return UIImage(named: "reminders") ?? UIImage()
        case .speech:
            return UIImage(named: "speaker") ?? UIImage()
        case .quiz:
            return UIImage(named: "quiz") ?? UIImage()
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .speech:
            return SpeechViewController()
        case .quiz:
            return QuizViewController()
        case .random:
            return DetailsViewController(word: nil)
        case .remind:
            return RemindViewController()
        }
    }
    
}
