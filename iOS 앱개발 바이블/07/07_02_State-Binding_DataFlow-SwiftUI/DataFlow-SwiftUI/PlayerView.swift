//
//  PlayerView.swift
//  DataFlow-SwiftUI
//
//  Created by joonwon lee on 2022/05/21.
//

import SwiftUI

struct PlayerView: View {
    let episode: Episode
    // @State를 통해 isPlaying의 상태가 바뀌면 body뷰를 다시 렌더링해옴
    @State private var isPlaying: Bool = false
    
    var body: some View {
        VStack(spacing: 20) { // 수직으로 콘텐츠 나열
            Text(episode.title) // 제목
                .font(.largeTitle) // 타이틀 스타일
            Text(episode.showTitle) // 쇼 이름
                .font(.title3) // 타이틀 스타일
                .foregroundColor(.gray) // 폰트 컬러
            
            // PlayerView의 상태를 참조해서 가지고 있는 서브뷰
            // 진짜 상태를 보낼 때 $사인
            PlayButton(isPlaying: $isPlaying)
            PlayingStatusView(isPlaying: $isPlaying)
            
            // control + command + e : 같은 이름 한 번에 바꾸기 가능
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(episode: Episode.list[0])
    }
}

