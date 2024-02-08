//
//  StockRankRow.swift
//  StockRank-SwiftUI
//
//  Created by 김정윤 on 12/25/23.
//

import SwiftUI

struct StockRankRow: View {
    
    var stock: StockModel
    
    var body: some View {
        HStack{
            Text("\(stock.rank)")
                .font(.system(size: 16, weight: .bold))
                .frame(width: 30)
                .foregroundColor(.blue)
            Image("\(stock.imageName)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            VStack(alignment: .leading, spacing: 5){
                Text("\(stock.name)")
                    .font(.system(size: 12))
                    .foregroundStyle(.white)
                HStack {
                    Text("\(stock.price)원")
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                    Text("\(stock.diff * 100, specifier: "%.2f")%") // specifier 이용해서 소수점 2자리까지만 보여주기
                        .font(.system(size: 12))
                        .foregroundStyle(stock.diff > 0 ? .red : .blue)
                }
            }
            
            Spacer()
            
            Image(systemName: "heart.fill")
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
        
}

#Preview {
    StockRankRow(stock: StockModel.list[0])
}
