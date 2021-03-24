//
//  SearchHistoryCell.swift
//  T-Dict
//
//  Created by Tiến on 3/26/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import UIKit
import Reusable

final class SearchHistoryCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var deleteButton: UIButton!
    @IBOutlet private weak var selectButton: UIButton!
    var deleteTap: ((Int) -> Void)?
    var selectTap: ((Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setContent(text: String, row: Int) {
        contentLabel.text = text
        deleteButton.tag = row
        selectButton.tag = row
    }
    
    @IBAction func deleteTap(_ sender: UIButton) {
        deleteTap?(sender.tag)
    }
    
    @IBAction func selectTap(_ sender: UIButton) {
        selectTap?(sender.tag)
    }
}
