//
//  BannerCell.swift
//  SpotifyPaywall
//
//  Created by joonwon lee on 2022/04/30.
//

import UIKit

class BannerCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() { // 불러올때
        super.awakeFromNib()
        self.layer.cornerRadius = 16 // 카드 코너 둥글게
    }
    
    func configure(_ info: BannerInfo) {
        titleLabel.text = info.title
        descLabel.text = info.description
        thumbnailImageView.image = UIImage(named: info.imageName)   
    }
}
