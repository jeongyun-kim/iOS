//
//  ContentView.swift
//  AppleFramework-SwiftUI
//
//  Created by joonwon lee on 2022/05/21.
//

import SwiftUI

struct FrameworkListView: View {
    
    // Data
    @State var list: [AppleFramework] = AppleFramework.list
    
    // 화면사이즈가 어떻게 되든 flexible하게 3등분해서 보여주겠다!
    let layout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        // Grid 만들기
        // - UIKit : UICollectionView
        // -> Data, Presentation, Layout
        // - SwiftUI : LazyVGrid, LazyHGrid
        // -> Data(@State), Presentation(Cell), Layout
        // 이런 형태로 그리드를 만들거야
        NavigationView{
            ScrollView {
                LazyVGrid(columns: layout){
                    ForEach(list) { item in
                        FrameworkCell(framework: item)
                    }
                }
                .padding([.top, .leading, .trailing], 16.0) // 상단, 좌우 패딩

            }
            .navigationTitle("🎄Apple Framework")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FrameworkListView()
    }
}
