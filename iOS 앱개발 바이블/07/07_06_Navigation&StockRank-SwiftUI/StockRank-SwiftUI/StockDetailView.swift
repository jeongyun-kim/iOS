//
//  StockDetailView.swift
//  StockRank-SwiftUI
//
//  Created by 김정윤 on 12/25/23.
//

import SwiftUI

struct StockDetailView: View {
    // 진짜 데이터를 참조하는 바인딩
    @Binding var stock: StockModel
    
    var body: some View {
        VStack(spacing: 20) {
            Image(stock.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
            Text(stock.name)
                .font(.system(size: 30, weight: .bold))
            Text("\(stock.price)원")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(stock.diff > 0 ? .red : .blue)
        }
    }
}

#Preview {
    // Binding 해온 값 임의로 꽂아주기 .constant
    StockDetailView(stock: .constant(StockModel.list[0]))
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/) // 기본적으로 다크모드 고정
}
