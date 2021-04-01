//
//  AlertViewController.swift
//  T-Dict
//
//  Created by Tiến on 3/31/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import UIKit
import Then

final class AlertViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private let icons = [ListIcon.star, ListIcon.tree, ListIcon.food, ListIcon.car]
    var didTapCancel: (() -> Void)?
    var lastIndex: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
    }
    
    func configCollectionView() {
        collectionView.do {
            $0.dataSource = self
            $0.dataSource = self
            $0.delegate = self
            $0.allowsMultipleSelection = false
            $0.register(cellType: IconCell.self)
            let layout = UICollectionViewFlowLayout().then {
                $0.scrollDirection = .horizontal
                $0.itemSize = CGSize(width: collectionView.height, height: collectionView.height - 10)
            }
            $0.collectionViewLayout = layout
        }
    }
    
    @IBAction func cancelTap(_ sender: Any) {
        didTapCancel?()
    }
    
    @IBAction func didTapAdd(_ sender: Any) {
    }
}

extension AlertViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as IconCell
        cell.setContent(icon: icons[indexPath.row].icon)
        return cell
    }
}
