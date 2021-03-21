//
//  DefinitionViewController.swift
//  T-Dict
//
//  Created by Tiến on 3/19/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import UIKit

class DefinitionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet private weak var wordLabel: UILabel!
    @IBOutlet private weak var pronounceLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    private let tableSection = ["Definition","Example"]
    private var data = [[String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableViews()
    }
    
    func configTableViews() {
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DefineTableViewCell.nib(), forCellReuseIdentifier: DefineTableViewCell.identifier)
        tableView.contentInset = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
        let defi = ["some definition very very very long"]
        let example = ["some very very long example"]
        data.append(defi)
        data.append(example)
    }
    
    func config(word: String) {
        wordLabel.text = word
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DefineTableViewCell.identifier, for: indexPath) as? DefineTableViewCell
        cell?.config(text: "→ \(data[indexPath.section][indexPath.row])" )
        return cell ?? UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableSection.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 20, y: 0, width: tableView.width, height: 30))
        view.backgroundColor = .clear
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.width, height: 30))
        label.text = tableSection[section]
        label.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(label)
        return view
    }
}
