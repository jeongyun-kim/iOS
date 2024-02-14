//
//  StockRankViewModel.swift
//  StockRank-SwiftUI
//
//  Created by 김정윤 on 12/25/23.
//

import Foundation

final class StockRankViewModel: ObservableObject {
    @Published var models: [StockModel] = StockModel.list
    
    var numberOfFavorites: Int {
        let favoriteStocks = models.filter { $0.isFavorite } // isFavorite == true인 model들만 가져오기
        return favoriteStocks.count
    }
}
