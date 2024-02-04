//
//  ImageView.swift
//  SwiftUI-Basic
//
//  Created by joonwon lee on 2022/05/21.
//

import SwiftUI

struct ImageView: View {
    var body: some View {
        Image(systemName: "sun.max.fill")
            .renderingMode(.original) // 이미지 컬러
            .resizable() // 사이즈 키우기
            .aspectRatio(contentMode: .fit) // 비율에 맞춰서 커지게 수정
        // 이 modifier 순서를 반대로 하면 에러가 날 수 있음
        // aspectRatio의 return이 View이기 때문
        // Image => View는 가능 / View => Image는 불가능!
        // 결론 : 이미지는 이미지 관점에서부터 처리하고 이후에 뷰관점에서 처리
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
