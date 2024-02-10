//
//  FrameworkCell.swift
//  AppleFramework-SwiftUI
//
//  Created by 김정윤 on 12/25/23.
//

import SwiftUI

struct FrameworkCell: View {
    
    var framework: AppleFramework
    
    var body: some View {
        VStack{
            Image(framework.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(framework.name)
                .font(.system(size: 16, weight: .bold))

        }
    }
}

#Preview {
    FrameworkCell(framework: AppleFramework.list[0])
        .previewLayout(.fixed(width: 160, height: 250))
    
}
