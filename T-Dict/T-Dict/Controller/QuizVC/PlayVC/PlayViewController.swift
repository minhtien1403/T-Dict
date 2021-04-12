//
//  PlayViewController.swift
//  T-Dict
//
//  Created by Tiến on 4/7/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import UIKit
import Then

final class PlayViewController: UIViewController {
    
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var stackView: UIStackView!
    private var pageController: UIPageViewController!
    private var currentQuestion = 0
    private var questionViewControllers = [UIViewController]()
    private let questionViewHeight: CGFloat = 500
    private var questions = [[String]]()
    private var options = [[String]]()
    private var trueAnswers = [Int]()
    private var quizList = [Quiz]()
    private var level = 0
    
    init(quizList: [Quiz], level: Int) {
        super.init(nibName: nil, bundle: nil)
        self.quizList = quizList
        self.level = level
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        setupQuestionViews()
        setupPageController()
    }
    
    func configView() {
        title = "Play"
        questionLabel.do {
            $0.font = UIFont.breeSerif(20)
            $0.text = "\(currentQuestion + 1)/10"
        }
    }
    
    func convertQuizData() {
        questions = quizList.map { $0.quiz ?? [] }
        options = quizList.map{ $0.option ?? [] }
        trueAnswers = quizList.map{ $0.correct ?? 0 }
    }
    
    func setupQuestionViews() {
        convertQuizData()
        questionViewControllers = (0..<quizList.count).map({ (index) -> QuestionViewController in
            let vc = QuestionViewController(question: questions[index], answer: options[index])
            vc.view.tag = index
            return vc
        })
    }
    
    func setupPageController() {
        guard let navBottom = navigationController?.navigationBar.bottom else {
            return
        }
        pageController = UIPageViewController(transitionStyle: .scroll,
                                              navigationOrientation: .horizontal,
                                              options: nil).then {
                                                $0.delegate = self
                                                $0.dataSource = self
                                                $0.view.backgroundColor = .clear
                                                $0.view.frame = CGRect(x: 0,
                                                                       y: navBottom + stackView.height,
                                                                       width: view.width,
                                                                       height: questionViewHeight)
                                                $0.setViewControllers([questionViewControllers[currentQuestion]],
                                                                      direction: .forward,
                                                                      animated: true,
                                                                      completion: nil)
                                                $0.didMove(toParent: self)
                                                addChild($0)
                                                view.addSubview($0.view)
        }
    }
    
    @IBAction func didTapPreviousQuestion(_ sender: Any) {
        if currentQuestion - 1 < 0 {
            return
        }
        currentQuestion = currentQuestion - 1
        questionLabel.text = "\(currentQuestion + 1)/10"
        pageController.setViewControllers([questionViewControllers[currentQuestion]],
                                          direction: .reverse,
                                          animated: true,
                                          completion: nil)
    }
    
    @IBAction func didTapNextQuestion(_ sender: Any) {
        if currentQuestion + 1 > questionViewControllers.count - 1 {
            return
        }
        currentQuestion = currentQuestion + 1
        questionLabel.text = "\(currentQuestion + 1)/10"
        pageController.setViewControllers([questionViewControllers[currentQuestion]],
                                          direction: .forward,
                                          animated: true,
                                          completion: nil)
    }
    
    @IBAction func didTapSubmitButton(_ sender: Any) {
        var score = 0
        for index in 0..<quizList.count {
            guard let vc = questionViewControllers[index] as? QuestionViewController else {
                return
            }
            if trueAnswers[index] == vc.userAnswer {
                score = score + 1
            }
        }
        if score > AppSetting.getBestScoreForLevel(level: level) {
            AppSetting.saveBestScoreForLevel(level: level, bestScore: score)
        }
        resultAlert(score: score, level: level)
    }
}

extension PlayViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        currentQuestion = viewController.view.tag
        if currentQuestion - 1 < 0 {
            return nil
        }
        return questionViewControllers[currentQuestion - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        currentQuestion = viewController.view.tag
        if currentQuestion + 1 > questionViewControllers.count - 1 {
            return nil
        }
        return questionViewControllers[currentQuestion + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewController = pageController.viewControllers?.first,
            let currentIndex = questionViewControllers.firstIndex(of: viewController) else {
                return
        }
        questionLabel.text = "\(currentIndex + 1)/10"
    }
    
}
