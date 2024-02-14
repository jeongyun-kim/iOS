//
//  StockDetailView.swift
//  StockRank-SwiftUI
//
//  Created by joonwon lee on 2022/06/06.
//

import SwiftUI

struct StockDetailView: View {
    
    @ObservedObject var viewModel: StockRankViewModel
    @Binding var stock: StockModel
    
    var body: some View {
        VStack(spacing: 40) {
            Text("# of My Favorites: \(viewModel.numberOfFavorites)")
                .font(.system(size: 20, weight: .bold, design: .default))
            Image(stock.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:120, height: 120)
            Text(stock.name)
                .font(.system(size: 30, weight: .bold))
            Text("\(stock.price)원")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(stock.diff > 0 ? .red : .blue)
            Button {
                stock.isFavorite.toggle()
            } label: {
                Image(systemName: "heart.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                // favorite으로 선택했다면 흰색, 아니라면 회색
                    .foregroundColor(stock.isFavorite ? .white : .gray)
            }
            
        }
    }
}

struct StockDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StockDetailView(
            viewModel: StockRankViewModel(),
            stock: .constant(StockModel.list[0]))
            .preferredColorScheme(.dark)
    }
}
