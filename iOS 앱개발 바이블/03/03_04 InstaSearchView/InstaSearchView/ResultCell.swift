//
//  ResultCell.swift
//  InstaSearchView
//
//  Created by 김정윤 on 11/5/23.
//

import UIKit

class ResultCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    // 재사용 되기위해 준비
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
    }
    // 구성할 때 이미지 받아와 세팅
    func configure(_ imageName: String){
        thumbnailImageView.image = UIImage(named: imageName)
    }
    
}
