//
//  FrameworkDetailViewModel.swift
//  AppleFramework
//
//  Created by 김정윤 on 12/21/23.
//

import Foundation
import Combine

final class FrameworkDetailViewModel {
   
    init(framework: AppleFramework) {
        self.framework = CurrentValueSubject(framework)
    }
    // Data => Output
    let framework: CurrentValueSubject<AppleFramework, Never>
    
    // User action => Input
    let buttonTapped = PassthroughSubject<AppleFramework, Never>()
    
    func learnMoreTapped() {
        buttonTapped.send(framework.value)
    }
}
