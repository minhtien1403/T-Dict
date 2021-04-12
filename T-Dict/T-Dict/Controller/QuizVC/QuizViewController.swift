//
//  QuizViewController.swift
//  T-Dict
//
//  Created by Tiến on 4/5/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import UIKit
import Then

final class QuizViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    private let numberOfRow = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configTableView()
    }
    
    func configView() {
        title = "Quiz"
    }
    
    func configTableView() {
        tableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(cellType: QuizTableCell.self)
        }
    }
    
}

extension QuizViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as QuizTableCell
        cell.setContent(level: indexPath.row + 1, icon: ListIcon.question.icon)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.height / 6
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.allowsSelection = false
        QuizAPI.shared.getQuiz(forLevel: indexPath.row + 1) { [weak self] QuizList in
            DispatchQueue.main.async {
                tableView.allowsSelection = true
                guard let quizlist = QuizList else {
                    self?.alertError(message: "Check Your Internet Connection")
                    return
                }
                let vc = PlayViewController(quizList: quizlist, level: indexPath.row + 1)
                vc.navigationItem.setHidesBackButton(true, animated: true)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}
