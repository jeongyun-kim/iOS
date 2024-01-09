//
//  FrameworkCell.swift
//  AppleFramework
//
//  Created by 김정윤 on 10/30/23.
//

import UIKit

class FrameworkCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        nameLabel.numberOfLines = 1
//        nameLabel.adjustsFontSizeToFitWidth = true // 폰트사이즈를 알맞게 조정해라
//    }
    
    func configure(_ framework: AppleFramework) {
        thumbnailImageView.image = UIImage(named: framework.imageName)
        nameLabel.text = framework.name
    }
}
