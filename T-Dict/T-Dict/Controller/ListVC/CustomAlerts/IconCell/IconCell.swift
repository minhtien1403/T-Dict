//
//  IconCell.swift
//  T-Dict
//
//  Created by Tiến on 4/1/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import UIKit
import Reusable

final class IconCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var iconImage: UIImageView!
    
    override var isSelected: Bool {
        willSet(newValue) {
            contentView.backgroundColor = newValue ? UIColor.gray : UIColor.white
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setContent(icon: UIImage) {
        iconImage.image = icon
    }
}
