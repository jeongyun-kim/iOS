//
//  OnboardingCell.swift
//  NRCOnboarding
//
//  Created by 김정윤 on 11/6/23.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    func configure(_ message: OnboardingMessage) {
        imageView.image = UIImage(named: message.imageName)
        titleLabel.text = message.title
        descLabel.text = message.description
    }
}
