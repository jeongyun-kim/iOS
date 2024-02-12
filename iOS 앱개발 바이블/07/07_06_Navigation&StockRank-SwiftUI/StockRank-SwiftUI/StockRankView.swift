//
//  ContentView.swift
//  StockRank-SwiftUI
//
//  Created by joonwon lee on 2022/05/21.
//

import SwiftUI

struct StockRankView: View {
    // 진짜 데이터
    @State var list = StockModel.list
    
    var body: some View {
        // 내비게이션 뷰 안에 내비게이션 링크를 넣어서 상세뷰 푸쉬
        NavigationView{
            // 바인딩 되고있는 진짜 데이터 이용 -> $
            List($list) { $item in
                // 리스트의 셀의 스타일을 지키고 싶을 때 ZStack을 이용한 꼼수ㅎ
                ZStack{
                    // 클릭이 됐을 때 어디로 보낼거야 ?
                    NavigationLink{
                        StockDetailView(stock: $item)
                    } label: {
                        EmptyView()
                    }
                    StockRankRow(stock: $item)
                }
                .listRowInsets(EdgeInsets())
                .frame(height: 80)
            }
            .listStyle(.plain)
            .navigationTitle("📈 Stock Rank")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StockRankView()
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
