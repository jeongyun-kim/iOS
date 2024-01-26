//
//  FrameworkListViewModel.swift
//  AppleFramework
//
//  Created by 김정윤 on 12/21/23.
//

import Foundation
import Combine

// viewModel에는 데이터 정의, 입출력 처리, 네트워크 처리 등이 들어옴!

// final : 명시적으로 상속되지 않음을 표시, 런타임 효율 증가
final class FrameworkListViewModel {
    init(items: [AppleFramework], selectedItem: AppleFramework? = nil) {
        self.items = CurrentValueSubject(items)
        self.selectedItem = CurrentValueSubject(selectedItem)
    }
    // Data => Output
    let items: CurrentValueSubject<[AppleFramework], Never> // 컬렉션뷰 보여주는 publisher
    let selectedItem: CurrentValueSubject<AppleFramework?, Never> // 선택한 애플 프레임워크의 디테일 뷰를 UI에 뿌려주는 역할
    
    // User Action => Input
    // 사용자가 여러 항목들 중 하나 선택했을 때
    let didSelect = PassthroughSubject<AppleFramework, Never>()
    func didSelect(at indexPath: IndexPath) { // 아이템을 하나 선택했을 때, 해당 아이템의 인덱스를 받아옴
        let item = items.value[indexPath.item] // item = 항목들의 요소 중 선택한 항목의 요소
        selectedItem.send(item) // 해당 요소의 디테일뷰를 보여주는 Publisher에 보내기
    }
}
