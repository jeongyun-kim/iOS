//
//  ButtonView.swift
//  SwiftUI-Basic
//
//  Created by joonwon lee on 2022/05/21.
//

import SwiftUI

struct ButtonView: View {
    var body: some View {
        Button {
            print("button tapped")
        } label: {
            Text("Click Me")
                .font(.system(size: 20, weight: .bold, design: .default))
                .foregroundStyle(.white) // 텍스트 컬러
        }
        .padding() // 좌우 여백
        .frame(height: 100) // 상하 길이
        .background(.pink) // 백그라운드 컬러
        .cornerRadius(20) // 버튼 코너 깎기
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
