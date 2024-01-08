//  StockRankCollectionViewCell

import UIKit

class StockRankCollectionViewCell: UICollectionViewCell {
    // ui component를 연결하자
    // ui component에 데이터를 업데이트하는 코드를 넣자
    @IBOutlet weak var rankLabel: UILabel! // 순위
    @IBOutlet weak var companyIconImageView: UIImageView! // 회사 로고
    @IBOutlet weak var diffLabel: UILabel! // 가격 등락폭
    @IBOutlet weak var companyPriceLabel: UILabel! // 가격
    @IBOutlet weak var companyNameLabel: UILabel! // 회사명
    
    func configure(_ stock: StockModel) {
        rankLabel.text = "\(stock.rank)"
        companyIconImageView.image = UIImage(named: stock.imageName)
        companyNameLabel.text = "\(stock.name)"
        companyPriceLabel.text = "\(convertToCurrencyFormat(price: stock.price))원"
        diffLabel.text = "\(textColorChange(diff: stock.diff))%"
    }
    // 가격에 콤마 넣어주기
    func convertToCurrencyFormat(price: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0 // 소수점 안 보여주기
        let result = numberFormatter.string(from: NSNumber(value: price)) ?? "" // 값이 없으면 공백값 넘겨줘 <- 강제 언랩핑의 경우 크래쉬가 날 수 있음
        return result
    }
    func textColorChange(diff: Double) -> Double {
        if diff < 0 {
            diffLabel.textColor = UIColor.blue
        } else {
            diffLabel.textColor = UIColor.red
        }
        return diff
    }
}
