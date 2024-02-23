//
//  UserProfileViewModel.swift
//  GithubUserSearch
//
//  Created by 김정윤 on 12/26/23.
//

import Foundation
import Combine

final class UserProfileViewModel: ObservableObject {
    
    let network: NetworkService
    let loginId: String
    var subscriptions = Set<AnyCancellable>()
    
    // 선택된 유저
    @Published var selectedUser: UserProfile?
    
    // 외부로부터 값 주입받기
    init(network: NetworkService, loginId: String) {
        self.network = network
        self.loginId = loginId
    }
    
    
    // 사용자 불러왔을 때 값이 nil이 아니면~ nil이면~
    var name: String {
        return selectedUser?.name ?? "n/a"
    }
    var login: String {
        return selectedUser?.login ?? "n/a"
    }
    var followers: String {
        guard let value = selectedUser?.followers else { return "" }
        return "followers: \(value)"
    }
    var following: String {
        guard let value = selectedUser?.following else { return "" }
        return "followings: \(value)"
    }
    var imageUrl: URL? {
        return selectedUser?.avatarUrl
    }
    
    
    // id 받아와서 유저 검색하기
    func search(keyword: String) {
        let resource: Resource<UserProfile> = Resource(
            base: "https://api.github.com/",
            path: "users/\(keyword)",
            params: [:],
            header: ["Content-Type": "application/json"]
        )
        // resource 요청
        network.load(resource)
            .receive(on: RunLoop.main) // 메인스레드에서 돌기
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.selectedUser = nil
                    print("error: \(error)")
                case.finished: break
                }
            }, receiveValue: { user in // 선택된 유저값에 받아온 유저값 넣기 
                self.selectedUser = user
            })
            .store(in: &subscriptions)
    }
}
