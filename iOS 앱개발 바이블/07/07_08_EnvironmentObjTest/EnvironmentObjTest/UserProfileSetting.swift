//
//  UserProfileSetting.swift
//  EnvironmentObjTest
//
//  Created by 김정윤 on 12/25/23.
//

import Foundation

final class UserProfileSetting: ObservableObject {
    @Published var name: String = ""
    @Published var age: Int = 0
    
    func haveBirthday() {
        age += 1
    }
}
