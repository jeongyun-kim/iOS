//
//  ContentView.swift
//  StockRank-SwiftUI
//
//  Created by joonwon lee on 2022/05/21.
//

import SwiftUI

struct StockRankView: View {
    
    @State var list = StockModel.list
    
    var body: some View {
        
        List(list) { stock in
            StockRankRow(stock: stock)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowSeparator(.hidden) // 구분자 안 보이게
                .frame(height: 80)
        }
        .listStyle(.plain) // List의 스타일을 안 쓰겠다
        .background(.black)
        
//        ScrollView{
//            ForEach(list, id:\.self) { stock in
//               
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StockRankView()
    }
}
