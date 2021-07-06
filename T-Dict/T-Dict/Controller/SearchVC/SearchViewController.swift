//
//  SearchViewController.swift
//  T-Dict
//
//  Created by Tiến on 3/16/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import UIKit

final class SearchViewController: BaseViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var clearButton: UIButton!
    let rowHeight: CGFloat = 50
    var searchBarIsEmpty = true
    var searchSuggestion = [String]()
    
    //MARK: - ConfigView
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        configTableView()
        searchBar.delegate = self
    }
    
    func configViews() {
        title = "Search"
        clearButton.isHidden = true
        clearButton.isEnabled = false
    }
    
    func configTableView() {
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: SearchHistoryCell.self)
        tableView.register(cellType: SuggestCell.self)
        tableView.backgroundColor = .white
    }
    
    func pushToDetailsView(word: String) {
        let vc = DetailsViewController(word: word)
        navigationController?.pushViewController(vc, animated: true)
        cancelSearchBar()
        tableView.reloadData()
    }
    
    @IBAction func didTapClearSearchHistory(_ sender: Any) {
        AppSetting.searchHistory.removeAll()
        tableView.reloadData()
    }
}

extension SearchViewController: UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    //MARK: -Config Search Bar
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tableView.isHidden = false
        searchBar.showsCancelButton = true
        view.backgroundColor = .systemGray6
        clearButton.isEnabled = true
        clearButton.isHidden = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tableView.isHidden = true
        view.backgroundColor = .white
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        cancelSearchBar()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let word = searchBar.text, !word.isEmpty else {
            cancelSearchBar()
            return
        }
        setUpSearchHistory(word: word)
    }
    
    func setUpSearchHistory(word: String) {
        if AppSetting.searchHistory.contains(word) {
            guard let index = AppSetting.searchHistory.firstIndex(of: word) else {
                return
            }
            AppSetting.searchHistory.remove(at: index)
            AppSetting.searchHistory.insert(word, at: 0)
        } else {
            AppSetting.searchHistory.insert(word, at: 0)
        }
        pushToDetailsView(word: word)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchSuggestion.removeAll()
        if searchText.isEmpty {
            searchBarIsEmpty = true
            tableView.reloadData()
        } else {
            searchBarIsEmpty = false
            searchSuggestion.append(searchText)
            APIService.shared.getSuggest(word: searchText) { [weak self] res in
                guard let suggestions = res?.also else {
                    return
                }
                DispatchQueue.main.async {
                    self?.searchSuggestion.append(contentsOf: suggestions)
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    func cancelSearchBar() {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        clearButton.isHidden = true
        clearButton.isEnabled = false
        searchBarIsEmpty = true
        tableView.reloadData()
    }
    //MARK: - Config Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchBarIsEmpty ? AppSetting.searchHistory.count : searchSuggestion.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchBarIsEmpty {
            let historyCell = tableView.dequeueReusableCell(for: indexPath) as SearchHistoryCell
            historyCell.setContent(text: AppSetting.searchHistory[indexPath.row], row: indexPath.row)
            historyCell.deleteTap = { row in
                AppSetting.searchHistory.remove(at: row)
                tableView.reloadData()
            }
            historyCell.selectTap = { [weak self] row in
                self?.searchBar.text = AppSetting.searchHistory[row]
                self?.searchBar(self?.searchBar ?? UISearchBar(), textDidChange: AppSetting.searchHistory[row])
            }
            return historyCell
        } else {
            let suggestCell = tableView.dequeueReusableCell(for: indexPath) as SuggestCell
            suggestCell.setContent(text: searchSuggestion[indexPath.row], row: indexPath.row)
            suggestCell.selectTap = { [weak self] row in
                self?.searchBar.text = self?.searchSuggestion[row]
                self?.searchBar(self?.searchBar ?? UISearchBar(), textDidChange: self?.searchSuggestion[row] ?? "")
            }
            return suggestCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if searchBarIsEmpty {
            setUpSearchHistory(word: AppSetting.searchHistory[indexPath.row])
        } else {
            setUpSearchHistory(word: searchSuggestion[indexPath.row])
        }
    }
}
