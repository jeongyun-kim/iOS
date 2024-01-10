//
//  FocusCell.swift
//  HeadSpaceFocus
//
//  Created by 김정윤 on 11/27/23.
//

import UIKit

class FocusCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() { // 불러올때 
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.systemIndigo // 컨텐츠 뷰 색깔 주기
        contentView.layer.cornerRadius = 10 // 컨텐츠 뷰 코너 둥글게
    }
    
    func configure(_ item: Focus) {
        titleLabel.text = item.title
        descLabel.text = item.description
        imageView.image = UIImage(systemName: item.imageName)?.withRenderingMode(.alwaysOriginal) 
        // alwaysTemplate로 되어있던것을 현재 설정(multicolor)로 변경
        // alwaysTemplate은 색깔무시하고 그냥 파란색..!
    }
}
