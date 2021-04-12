//
//  DefineTableViewCell.swift
//  T-Dict
//
//  Created by Tiến on 3/23/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import UIKit

class DefineTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var label: UILabel!
    static let identifier = "DefineTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "DefineTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setContent(text: String) {
        label.text = "→ \(text)"
        label.textColor = .systemBlue
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
    }
}
