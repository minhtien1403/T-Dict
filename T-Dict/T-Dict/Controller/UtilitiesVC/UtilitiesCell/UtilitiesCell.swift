//
//  UtilitiesCell.swift
//  T-Dict
//
//  Created by Tiến on 4/4/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import UIKit
import Reusable
import Then

final class UtilitiesCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var view: UIView!
    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImage.contentMode = .scaleAspectFit
        view.do {
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = false
            $0.layer.shadowColor = UIColor.darkGray.cgColor
            $0.layer.shadowRadius = 5
            $0.layer.shadowOpacity = 0.5
            $0.layer.shadowOffset = CGSize(width: 1, height: 1)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setContent(title: String, icon: UIImage) {
        titleLabel.text = title
        iconImage.image = icon
    }
    
}
