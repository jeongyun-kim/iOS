//
//  SearchViewController.swift
//  GithubUserSearch
//
//  Created by joonwon lee on 2022/05/25.
//

import UIKit
import Combine
// import Kingfisher

class UserProfileViewController: UIViewController {
    
    // 뷰모델 생성
    var viewModel: SearchViewModel!
    
    var subscriptions = Set<AnyCancellable>()
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SearchViewModel(network: NetworkService(configuration: .default), selectedUser: nil)
        
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
        viewModel.selectedUser
            .receive(on: RunLoop.main)
            .sink { [unowned self] _ in
                self.nameLabel.text = self.viewModel.name
                self.loginLabel.text = self.viewModel.login
                self.followerLabel.text = self.viewModel.followers
                self.followingLabel.text = self.viewModel.following
                self.thumbnail.load(url: user.avatarUrl)
            }.store(in: &subscriptions)
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
        // 검색어
        guard let keyword = searchBar.text, !keyword.isEmpty else { return }
        // 뷰모델
        viewModel.search(keyword: keyword)
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
