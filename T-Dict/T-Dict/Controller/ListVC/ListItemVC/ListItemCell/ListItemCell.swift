//
//  ListItemCell.swift
//  T-Dict
//
//  Created by Tiến on 4/2/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import UIKit
import Reusable

class ListItemCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var wordLabel: UILabel!
    @IBOutlet private weak var pronounceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setContent(word: String, pronounce: String) {
        wordLabel.text = word
        pronounceLabel.text = pronounce
    }
    
}
