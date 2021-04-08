//
//  QuestionViewController.swift
//  T-Dict
//
//  Created by Tiến on 4/8/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import UIKit
import Then

final class QuestionViewController: UIViewController {
    
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var firstAnswerButton: RounedButton!
    @IBOutlet private weak var secondAnswerButton: RounedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        textView.do {
            $0.backgroundColor = .white
            $0.textAlignment = .center
            $0.isEditable = false
            $0.backgroundColor = .white
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 5
        }
    }
    
    @IBAction func didTapAnswerA(_ sender: UIButton) {
        if firstAnswerButton.isSelected {
            return
        }
        firstAnswerButton.isSelected = !sender.isSelected
        secondAnswerButton.isSelected = !firstAnswerButton.isSelected
    }
    
    @IBAction func didTapAnswerB(_ sender: UIButton) {
        if secondAnswerButton.isSelected {
            return
        }
        secondAnswerButton.isSelected = !sender.isSelected
        firstAnswerButton.isSelected = !firstAnswerButton.isSelected
    }
}
