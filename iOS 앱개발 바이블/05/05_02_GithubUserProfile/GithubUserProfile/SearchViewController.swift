//
//  SearchViewController.swift
//  GithubUserSearch
//
//  Created by joonwon lee on 2022/05/25.
//

import UIKit
import Combine
import Kingfisher

class UserProfileViewController: UIViewController {
    // 네트워크 서비스 생성
    let network = NetworkService(configuration: .default)
    
    @Published private(set) var user: UserProfile?
    var subscriptions = Set<AnyCancellable>()
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        embedSearchControl()
        bind()
    }
    
    private func setupUI() {
        thumbnail.layer.cornerRadius = 80 // 사진의 크기가 160이기
    }
    
    // 서치바 설정
    private func embedSearchControl() {
        self.navigationItem.title = "Search" // navigation title
        
        let searchController = UISearchController(searchResultsController: nil)
        // 서치바를 눌렀을 때 네비게이션 바가 사라지지 않음(false)
        searchController.hidesNavigationBarDuringPresentation = false
        // 서치바에 값 미리 넣어두기
        searchController.searchBar.placeholder = "jeongyun-kim"
        // 현재 어떤 값이 들어왔는지 확인 가능
        searchController.searchResultsUpdater = self
        // 엔터눌러서 검색 가능하도록 delegate 가져오기
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
        
    }
    
    private func bind() {
        $user
            .receive(on: RunLoop.main)
            .sink { [unowned self] result in
                self.update(result)
            }.store(in: &subscriptions)
    }
    
    // updateUI
    private func update(_ user: UserProfile?) {
        guard let user = user else {
            // user가 없을 때
            self.nameLabel.text = "n/a"
            self.loginLabel.text = "n/a"
            self.followerLabel.text = ""
            self.followingLabel.text = ""
            self.thumbnail.image = nil
            return
        }
        self.nameLabel.text = user.name
        self.loginLabel.text = user.login
        self.followerLabel.text = "follower: \(user.followers)"
        self.followingLabel.text = "following: \(user.following)"
        // image url -> image
        // Kingfisher 이용해서 쉽게 사용 가능
        thumbnail.load(url: user.avatarUrl)
    }
}

extension UserProfileViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // 서치바에 입력된 키워드 확인 가능
        let keyword = searchController.searchBar.text
        print("search: \(keyword)")
    }
}

extension UserProfileViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { 
        // 서치바에서 엔터 클릭했을 때
        print("button tapped: \(searchBar.text)")
        
        // 검색어
        guard let keyword = searchBar.text, !keyword.isEmpty else { return }
        
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
                    self.user = nil // 만약 없는 user를 검색하면 에러메시지가 print됨
                case .finished : 
                    break
                }
            } receiveValue: { user in
                self.user = user
            }.store(in: &subscriptions)
    
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
