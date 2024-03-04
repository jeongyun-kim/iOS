//
//  BenefitCell.swift
//  TossBenefitTab
//
//  Created by 김정윤 on 1/2/24.
//

import UIKit

class BenefitCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(item: Benefit) {
        titleLabel.text = item.title
        descLabel.text = item.description
        imageView.image = UIImage(named: item.imageName)
    }
}
