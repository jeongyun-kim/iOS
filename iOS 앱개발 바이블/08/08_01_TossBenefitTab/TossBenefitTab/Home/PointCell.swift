//
//  PointCell.swift
//  TossBenefitTab
//
//  Created by 김정윤 on 1/2/24.
//

import UIKit

class PointCell: UICollectionViewCell {
    
    @IBOutlet weak var myPointCountLabel: UILabel!
    @IBOutlet weak var myPointLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(point: MyPoint) {
        imageView.image = UIImage(named: "ic_point")
        myPointLabel.text = "내 포인트"
        myPointCountLabel.text = "\(point.point) 원"
    }
}
