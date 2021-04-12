//
//  UtilitiesViewController.swift
//  T-Dict
//
//  Created by Tiến on 3/16/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import UIKit
import Then

final class UtilitiesViewController: BaseViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private let utilities: [Utilities] = [.speech, .quiz, .random, .remind]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func configViews() {
        title = "Utilities"
        tableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(cellType: UtilitiesCell.self)
            $0.separatorStyle = .none
        }
    }
}

extension UtilitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return utilities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as UtilitiesCell
        cell.setContent(title: utilities[indexPath.row].rawValue, icon: utilities[indexPath.row].icon)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.height / 8
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(utilities[indexPath.row].viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
