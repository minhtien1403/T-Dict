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
    private var tableData = [String]()
    private var screenType: ScreenType?
    private let rowHeight = 25
    
    init(type: ScreenType) {
        super.init(nibName: nil, bundle: nil)
        self.screenType = type
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        APIService.shared.getPronounce(word: word) { [weak self] (res) in
            guard let pronounciation = res?.pronunciation, let pronounce = pronounciation.all else {
                return
            }
            DispatchQueue.main.async {
                self?.pronounceLabel.text = pronounce
            }
        }
        guard let type = screenType else {
            return
        }
        switch type {
        case .synonyms:
            APIService.shared.getSynonyms(word: word) { [weak self] (res) in
                guard let data = res?.synonyms else {
                    return
                }
                self?.updateUI(data:data)
            }
        case .antonyms:
            APIService.shared.getAntonyms(word: word) { [weak self] (res) in
                guard let data = res?.antonyms else {
                    return
                }
                self?.updateUI(data: data)
            }
        case .rhymes:
            APIService.shared.getRhymes(word: word) { [weak self] (res) in
                guard let rhymes = res?.rhymes, let data = rhymes.all else {
                    return
                }
                self?.updateUI(data: data)
            }
        }
    }
    
    func updateUI(data: [String]) {
        DispatchQueue.main.async {
            self.tableData = data
            self.tableView.reloadData()
        }
    }
    //MARK: - Config TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DefineTableViewCell.identifier, for: indexPath) as? DefineTableViewCell
        cell?.setContent(text: tableData[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let word = tableData[indexPath.row]
        let vc = DetailsViewController(word: word)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(rowHeight)
    }
}
