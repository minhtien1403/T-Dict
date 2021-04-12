//
//  ViewController+Alert.swift
//  T-Dict
//
//  Created by Tiến on 4/2/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func alertError(message: String) {
        let alert = UIAlertController(title: "Something wrong",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel,
                                      handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func resultAlert(score: Int, level: Int) {
        let resultAlert = UIAlertController(title: "Result",
                                            message: "Your score: \(score) \nBest Score: \(AppSetting.getBestScoreForLevel(level: level))",
                                            preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "Done", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        resultAlert.addAction(doneAction)
        present(resultAlert, animated: true)
    }
}
