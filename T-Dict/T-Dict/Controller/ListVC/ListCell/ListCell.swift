//
//  ListCell.swift
//  T-Dict
//
//  Created by Tiến on 3/30/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import UIKit
import Reusable

final class ListCell: UITableViewCell, NibReusable  {
    
    @IBOutlet private weak var listIcon: UIImageView!
    @IBOutlet private weak var listName: UILabel!
    @IBOutlet private weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        listName.font = UIFont.breeSerif(30)
        listIcon.contentMode = .center
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setContent(text: String, icon: ListIcon) {
        listName.text = text
        listIcon.image = icon.icon
    }
}
