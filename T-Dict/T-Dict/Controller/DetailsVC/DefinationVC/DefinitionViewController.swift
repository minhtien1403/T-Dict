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
    private var tableData = [[String]]()
    private let readingSpeed: Float = 0.5

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
    }
    
    func config(word: String) {
        wordLabel.text = word
        APIService.shared.getPronounce(word: word) { [weak self] res in
            guard let pronounce = res?.pronunciation?.all else {
                return
            }
            DispatchQueue.main.async {
                self?.pronounceLabel.text = pronounce
            }
        }
        APIService.shared.getDefines(word: word) { [weak self] res in
            guard let definitions = res?.definitions else {
                return
            }
            let defines = definitions.map {
                $0.definition ?? ""
            }
            DispatchQueue.main.async {
                self?.tableData.insert(defines, at: 0)
                self?.typeLabel.text = definitions.first?.partOfSpeech
                self?.tableView.reloadData()
            }
        }
        APIService.shared.getExamples(word: word) { [weak self] res in
            guard let examples = res?.examples else {
                return
            }
            DispatchQueue.main.async {
                self?.tableData.append(examples)
                self?.tableView.reloadData()
            }
        }
    }
    
    func getPronounce() -> String {
        return pronounceLabel.text ?? ""
    }
    
    @IBAction func speakButtonTapped(_ sender: Any) {
        guard let word = wordLabel.text else {
            return
        }
        SpeechServices.shared.startReading(text: word, speed: readingSpeed)
    }
    
    // MARK: - Config table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DefineTableViewCell.identifier, for: indexPath) as? DefineTableViewCell
        cell?.setContent(text: tableData[indexPath.section][indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 20, y: 0, width: tableView.width, height: 30))
        view.backgroundColor = .white
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.width, height: 30))
        label.text = tableSection[section]
        label.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(label)
        return view
    }
}
