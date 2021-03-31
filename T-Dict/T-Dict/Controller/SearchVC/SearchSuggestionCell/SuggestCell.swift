//
//  SuggestCell.swift
//  T-Dict
//
//  Created by Tiến on 3/26/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import UIKit
import Reusable

final class SuggestCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var selectButton: UIButton!
    var selectTap: ((Int) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setContent(text: String, row: Int) {
        contentLabel.text = text
        selectButton.tag = row
    }
    
    @IBAction func didTapSelect(_ sender: UIButton) {
        selectTap?(sender.tag)
    }
}
