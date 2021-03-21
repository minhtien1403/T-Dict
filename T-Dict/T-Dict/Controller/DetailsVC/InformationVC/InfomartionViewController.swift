//
//  SynonymsViewController.swift
//  T-Dict
//
//  Created by Tiến on 3/19/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import UIKit

class InformationViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet private weak var wordLabel: UILabel!
    @IBOutlet private weak var pronounceLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    private var dumpData = ["Dog","Cat"]
    private let rowHeight = 25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableViews()
    }
    
    func configTableViews() {
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.contentInset = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
    }
    
    func config(word: String) {
        wordLabel.text = word
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dumpData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "→ " + dumpData[indexPath.row]
        cell.textLabel?.textColor = .systemBlue
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let vc = DetailsViewController()
        vc.word = dumpData[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(rowHeight)
    }
}
