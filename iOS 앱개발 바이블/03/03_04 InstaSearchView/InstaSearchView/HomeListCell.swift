//
//  HomeListCell.swift
//  InstaSearchView
//
//  Created by 김정윤 on 11/6/23.
//

import UIKit

class HomeListCell: UICollectionViewCell {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pictureImageView.image = nil
    }
    func configure(_ imageName: String) {
        pictureImageView.image = UIImage(named: imageName)
    }
}
