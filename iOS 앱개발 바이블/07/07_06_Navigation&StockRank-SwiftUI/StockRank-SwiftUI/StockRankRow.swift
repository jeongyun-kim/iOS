//
//  StockRankRow.swift
//  StockRank-SwiftUI
//
//  Created by joonwon lee on 2022/06/01.
//

import SwiftUI

struct StockRankRow: View {
    // 진짜 데이터를 참조하는 바인딩
    @Binding var stock: StockModel
    
    var body: some View {
        HStack {
            Text("\(stock.rank)")
                .font(.system(size: 16, weight: .bold))
                .frame(width: 30)
                .foregroundColor(.blue)
            Image("\(stock.imageName)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            VStack(alignment: .leading, spacing: 5) {
                Text("\(stock.name)")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                HStack {
                    Text("\(stock.price)원")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    Text("\(stock.diff * 100, specifier: "%.2f")  %")
                        .font(.system(size: 12))
                        .foregroundColor(stock.diff > 0 ? .red : .blue)
                }
            }
            
            Spacer()
            
            Image(systemName: "heart.fill")
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .foregroundColor(.gray)
                
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}

struct StockRankRow_Previews: PreviewProvider {
    static var previews: some View {
        // StackModel.list[2]를 넣어줬다고 가정하자
        StockRankRow(stock: .constant(StockModel.list[2]))
            .previewLayout(.fixed(width: 390, height: 80))
    }
}
