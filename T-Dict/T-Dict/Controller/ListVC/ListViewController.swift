//
//  ListViewController.swift
//  T-Dict
//
//  Created by Tiến on 3/16/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import UIKit

final class ListViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!
    private var lists = [List]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        configNavigationBar()
        configTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    //MARK: -Config View
    func configViews() {
        title = "List"
        view.backgroundColor = .systemGray6
        lists = CoreDataManager.ListManager.shared.fetchAllList()
    }
    
    func configNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.addIcon,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapAdd))
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: ListCell.self)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
    @objc func didTapAdd() {
        let alert = AlertViewController()
        alert.modalPresentationStyle = .overCurrentContext
        alert.didTapCancel = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
            self?.tabBarController?.tabBar.isHidden = false
        }
        alert.didTapAddNewList = { [weak self] name, icon in
            CoreDataManager.ListManager.shared.addNewList(name: name, icon: icon)
            self?.dismiss(animated: true, completion: nil)
            self?.lists = CoreDataManager.ListManager.shared.fetchAllList()
            self?.tableView.reloadData()
            self?.tabBarController?.tabBar.isHidden = false
        }
        present(alert, animated: true, completion: nil)
        tabBarController?.tabBar.isHidden = true
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as ListCell
        cell.setContent(text: lists[indexPath.row].name ?? "",
                        icon: ListIcon(rawValue: lists[indexPath.row].icon ?? "star") ?? ListIcon.star )
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 5
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
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            let item = lists[indexPath.row]
            CoreDataManager.ListManager.shared.deleteList(list: item)
            lists.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}
