//
//  ListItemViewController.swift
//  T-Dict
//
//  Created by Tiến on 4/2/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import UIKit
import Then

class ListItemViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private var parentList: String?
    private var items = [ListItem]()
    
    init(parentList: String) {
        super.init(nibName: nil, bundle: nil)
        self.parentList = parentList
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }
    
    func configTableView() {
        items = CoreDataManager.ListItemManager.shared.fetchAllItemInList(listName: parentList ?? "")
        tableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(cellType: ListItemCell.self)
        }
        
    }
}

extension ListItemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as ListItemCell
        cell.setContent(word: items[indexPath.row].word ?? "", pronounce: items[indexPath.row].pronounce ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.height / 7
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let word = items[indexPath.row].word else {
            return
        }
        let vc = DetailsViewController(word: word)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            let item = items[indexPath.row]
            CoreDataManager.ListItemManager.shared.deleteItem(item: item)
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}
