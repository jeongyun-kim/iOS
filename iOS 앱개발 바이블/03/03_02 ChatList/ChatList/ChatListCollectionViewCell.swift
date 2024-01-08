//
//  ChatListCollectionViewCell.swift
//  ChatList
//
//  Created by 김정윤 on 10/24/23.
//

import UIKit

class ChatListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var chatLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // 실행되면서 항목 꺼내올 때 사진을 둥글게 가져오도록 함
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnail.layer.cornerRadius = 40
    }
    
    // 보여줄 컨텐츠 업데이트
    func configure(_ chat: Chat) {
        thumbnail.image = UIImage(named: chat.name)
        nameLabel.text = chat.name
        chatLabel.text = chat.chat
        dateLabel.text = formattedDateString(dateString: chat.date)
    }
    
    func formattedDateString(dateString: String) -> String {
        // 2022-04-01 => 4/1
        // String -> Date -> String
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        // 문자열 -> date
        if let date = formatter.date(from: dateString) {
            // 시간 정보를 우리가 원하는대로 변경
            formatter.dateFormat = "M/d"
            return formatter.string(from: date)
        } else {
            return ""
        }
    }
}
