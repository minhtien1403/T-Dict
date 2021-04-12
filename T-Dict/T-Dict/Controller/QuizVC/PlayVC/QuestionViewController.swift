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
    private var question = [String]()
    private var answer = [String]()
    public var userAnswer = 0
    
    init(question: [String], answer: [String]) {
        super.init(nibName: nil, bundle: nil)
        self.question = question
        self.answer = answer
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            $0.text = question.reduce("", {
                $0 == "" ? $1 : $0 + ", " + $1
            })
        }
        firstAnswerButton.do {
            $0.setTitle(answer.first, for: .normal )
            $0.tag = 1
        }
        secondAnswerButton.do {
            $0.setTitle(answer[1, default: "..."], for: .normal )
            $0.tag = 2
        }
    }
    
    @IBAction func didTapAnswerA(_ sender: UIButton) {
        if firstAnswerButton.isSelected {
            return
        }
        userAnswer = sender.tag
        firstAnswerButton.isSelected = !sender.isSelected
        secondAnswerButton.isSelected = !firstAnswerButton.isSelected
    }
    
    @IBAction func didTapAnswerB(_ sender: UIButton) {
        if secondAnswerButton.isSelected {
            return
        }
        userAnswer = sender.tag
        secondAnswerButton.isSelected = !sender.isSelected
        firstAnswerButton.isSelected = !secondAnswerButton.isSelected
    }
}
