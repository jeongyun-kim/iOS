//
//  TodayCell.swift
//  TossBenefitTab
//
//  Created by 김정윤 on 1/2/24.
//

import UIKit

class TodayCell: UICollectionViewCell {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 콘텐츠뷰 둥글게
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        // 콘텐츠뷰 회색 연하게
        self.backgroundColor = UIColor.systemGray.withAlphaComponent(0.3)
        
        // 버튼 둥글게
        self.button.layer.masksToBounds = true
        self.button.layer.cornerRadius = 10
        
    }
    
    func configure(item: Benefit) {
        titleLabel.text = item.title
        button.setTitle(item.ctaTitle, for: .normal)
    }
}
