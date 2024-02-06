//
//  PlayingStatusView.swift
//  DataFlow-SwiftUI
//
//  Created by 김정윤 on 12/25/23.
//

import SwiftUI

struct PlayingStatusView: View {
    
    @Binding var isPlaying: Bool
    
    var body: some View {
        // playing중이라면 sun.max.fill
        // playing을 하고 있지 않다면 sun.max
        Image(systemName: isPlaying ? "sun.max.fill" : "sun.max")
            .resizable()
            .renderingMode(.original)
            .aspectRatio(contentMode: .fit)
            .frame(width: 80, height: 80)
    }
}
