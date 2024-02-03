//
//  SearchViewModel.swift
//  GithubUserSearch
//
//  Created by 김정윤 on 12/20/23.
//

import Foundation
import Combine

final class SearchViewModel {
    
    let network: NetworkService
    var subscriptions = Set<AnyCancellable>()
    
    init(network: NetworkService) {
        self.network = network
    }
    // Data => Output
    @Published private(set) var users = [SearchResult]()
    // let users: CurrentValueSubject<[SearchResult], Never>
    
    // User action => Input
    func search(keyword: String) {
        let resource: Resource<SearchUserResponse> = Resource(
            base: "https://api.github.com/",
            path: "search/users",
            params: ["q": keyword],
            header: ["Content-Type": "application/json"]
        )
        
        network.load(resource)
            .map { $0.items }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .assign(to: \.users, on: self)
            .store(in: &subscriptions)
    }
}
