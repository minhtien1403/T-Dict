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
    private var totalQuestion = 10
    private var questionViewControllers = [UIViewController]()
    private let questionViewHeight: CGFloat = 500
    
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
    
    func setupQuestionViews() {
        questionViewControllers = (0..<10).map({ (index) -> QuestionViewController in
            let vc = QuestionViewController()
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
        navigationController?.popViewController(animated: true)
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
