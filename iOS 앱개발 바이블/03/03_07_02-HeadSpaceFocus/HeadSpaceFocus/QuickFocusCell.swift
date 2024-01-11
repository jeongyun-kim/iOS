//
//  QuickFocusCell.swift
//  HeadSpaceFocus
//
//  Created by 김정윤 on 12/5/23.
//

import UIKit

class QuickFocusCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    func configure(_ quickFocus: QuickFocus) {
        thumbnailImageView.image = UIImage(named: quickFocus.imageName)
        titleLabel.text = quickFocus.title
        descLabel.text = quickFocus.description
    }
    
}




