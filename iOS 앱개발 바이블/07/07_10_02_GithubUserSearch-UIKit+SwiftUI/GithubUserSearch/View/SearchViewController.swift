//
//  SearchViewController.swift
//  GithubUserSearch
//
//  Created by joonwon lee on 2022/05/25.
//

import UIKit
import Combine
import SwiftUI

class SearchViewController: UIViewController {
    
    var viewModel: SearchViewModel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias Item = SearchResult
    var datasource: UICollectionViewDiffableDataSource<Section, Item>!
    enum Section {
        case main
    }
    
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SearchViewModel(network: NetworkService(configuration: .default))
        embedSearchControl()
        configureCollectionView()
        bind()
    }
    
    private func embedSearchControl() {
        self.navigationItem.title = "Search"
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "jeongyun-kim"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
    }
    
    private func configureCollectionView() {
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCell", for: indexPath) as? ResultCell else { return nil }
            cell.user.text = item.login
            return cell
        })
        
        
        collectionView.collectionViewLayout = layout()
        
        // collectionView의 아이템을 선택했을 때, 메소드 호출하기 위해
        collectionView.delegate = self
    }
    
    private func bind() {
        viewModel.$users
            .receive(on: RunLoop.main)
            .sink { users in
                var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                snapshot.appendSections([.main])
                snapshot.appendItems(users, toSection: .main)
                self.datasource.apply(snapshot)
            }.store(in: &subscriptions)
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
}


extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let keyword = searchController.searchBar.text
        print("search: \(keyword)")
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text, !keyword.isEmpty else { return }
        viewModel.search(keyword: keyword)
    }
}

// collectionView.delegate = self에서 약속한 프로토콜 구현
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("--> loginId: \(viewModel.users[indexPath.item].login)") // 선택한 아이디 출력
        // 선택한 아이디
        let loginID = viewModel.users[indexPath.item].login
        // 유저프로필 불러오는 뷰 모델에 선택한 아이디, 네트워크 서비스 전달
        let vm = UserProfileViewModel(network: NetworkService(configuration: .default), loginId: loginID)
        // 선택한 유저(아이디)의 정보가 담긴 유저프로필뷰를 유저프로필뷰모델을 이용해서 불러오기
        let userProfileView = UserProfileView(viewModel: vm)
        // UIKit에 SwiftUI 띄워주기 위해 hosting, SwiftUI 불러오기
        let hostingVC = UIHostingController(rootView: userProfileView)
        // navigation에 hosting한 뷰(UserProfileView) 찔러넣기
        navigationController?.pushViewController(hostingVC, animated: true)
    }
}
