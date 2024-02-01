//
//  SearchViewModel.swift
//  GithubUserProfile
//
//  Created by 김정윤 on 12/20/23.
//

import Foundation
import Combine

final class SearchViewModel {
    
    // 네트워크 서비스 생성
    let network: NetworkService
    // 외부에서 주입한 네트워크 서비스를 받겠다
    init(network: NetworkService, selectedUser: UserProfile?) {
        self.network = network
        self.selectedUser = CurrentValueSubject(selectedUser)
    }
    
    var subscriptions = Set<AnyCancellable>()
    
    // Data => Output
    // @Published private(set) var user: UserProfile?
    let selectedUser: CurrentValueSubject<UserProfile?, Never>
    
    var name: String {
        return selectedUser.value?.name ?? "n/a"
    }
    var login: String {
        return selectedUser.value?.login ?? "n/a"
    }
    var followers: String {
        guard let value = selectedUser.value?.followers else { return "" }
        return "followers: \(value)"
    }
    var following: String {
        guard let value = selectedUser.value?.following else { return "" }
        return "followings: \(value)"
    }
    
    // User Action => Input
    func search(keyword: String) {
        // Resource
        let resource = Resource<UserProfile>(
            base: "https://api.github.com/",
            path: "users/\(keyword)",
            params: [:],
            header: ["Content-Type":"application/json"])
        
        // Network Service
        network.load(resource)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion { // error 처리
                case .failure(let error) :
                    self.selectedUser.send(nil) // 만약 없는 user를 검색하면 에러메시지가 print됨
                case .finished :
                    break
                }
            } receiveValue: { user in
                self.selectedUser.send(user)
            }.store(in: &subscriptions)
    }
}
