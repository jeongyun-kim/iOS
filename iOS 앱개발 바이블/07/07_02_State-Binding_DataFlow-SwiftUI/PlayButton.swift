//
//  PlayButton.swift
//  DataFlow-SwiftUI
//
//  Created by 김정윤 on 12/25/23.
//

import SwiftUI

struct PlayButton: View {
    
    @Binding var isPlaying: Bool
    
    var body: some View {
        Button {
            self.isPlaying.toggle() // 버튼 토글
        } label: { // playing중이라면 puase이미지 <-> 아니라면 Play이미지
            Image(systemName: isPlaying ? "pause.circle": "play.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 80)
                .foregroundColor(.primary)
        }
    }
}
