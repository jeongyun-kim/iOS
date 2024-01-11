//
//  QuickFocusHeaderView.swift
//  HeadSpaceFocus
//
//  Created by 김정윤 on 12/5/23.
//

import UIKit

class QuickFocusHeaderView: UICollectionReusableView {
        
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(_ title: String) {
        titleLabel.text = title
    }
}
