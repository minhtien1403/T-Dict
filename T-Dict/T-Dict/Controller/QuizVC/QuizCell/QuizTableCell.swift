//
//  QuizTableCell.swift
//  T-Dict
//
//  Created by Tiến on 4/7/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import UIKit
import Reusable
import Then

final class QuizTableCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var view: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont.breeSerif(30)
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
    
    func setContent(level: Int, icon: UIImage) {
        titleLabel.text = "Level \(level)"
        iconImage.image = icon
    }
}
