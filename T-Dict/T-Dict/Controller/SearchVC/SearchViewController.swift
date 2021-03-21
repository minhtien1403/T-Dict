//
//  SearchViewController.swift
//  T-Dict
//
//  Created by Tiến on 3/16/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var clearButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        configTableView()
    }
    
    func configViews() {
        title = "Search"
        searchBar.delegate = self
        clearButton.isHidden = true
        clearButton.isEnabled = false
    }
    func configTableView() {
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 5
        tableView.contentInset = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        tableView.layer.borderColor = UIColor.black.cgColor
        tableView.layer.borderWidth = 0.5
        tableView.isHidden = true
    }
}
extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tableView.isHidden = false
        searchBar.showsCancelButton = true
        clearButton.isEnabled = true
        clearButton.isHidden = false
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tableView.isHidden = true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        caccelSearchBar()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let word = searchBar.text else {
            searchBar.endEditing(true)
            return
        }
        let vc = DetailsViewController()
        vc.word = word
        navigationController?.pushViewController(vc, animated: true)
        caccelSearchBar()
    }
    func caccelSearchBar() {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        clearButton.isHidden = true
        clearButton.isEnabled = false
    }
}

