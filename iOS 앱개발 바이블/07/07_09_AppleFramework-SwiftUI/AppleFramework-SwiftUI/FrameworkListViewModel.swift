//
//  FrameworkListViewModel.swift
//  AppleFramework-SwiftUI
//
//  Created by 김정윤 on 12/26/23.
//

import Foundation

final class FrameworkListViewModel: ObservableObject {
    @Published var models: [AppleFramework] = AppleFramework.list
    @Published var isShowingDetail: Bool = false
    
    // 선택된 아이템
    @Published var selectedItem: AppleFramework?
}
