//
//  PaywallViewController.swift
//  SpotifyPaywall
//
//  Created by joonwon lee on 2022/04/30.
//

import UIKit

 //https://developer.spotify.com/documentation/general/design-and-branding/#using-our-logo
 //https://developer.apple.com/documentation/uikit/nscollectionlayoutsectionvisibleitemsinvalidationhandler
// 과제: 아래 애플 샘플 코드 다운받아서 돌려보기  https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views

class PaywallViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let bannerInfos: [BannerInfo] = BannerInfo.list
    let colors: [UIColor] = [.systemPurple, .systemOrange, .systemPink, .systemRed] // 각 카드마다 사용할 컬러 리스트
    
    enum Section {
        case main
    }
    typealias Item = BannerInfo
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // presentation : diffable datasource
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as? BannerCell else {
                return nil
            }
            cell.configure(item)
            cell.backgroundColor = self.colors[indexPath.item]
            return cell
        })
        
        // data : snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(bannerInfos, toSection: .main)
        dataSource.apply(snapshot)
        
        // layout : compositional layout
        collectionView.collectionViewLayout = layout()
        // vertical로도 늘릴 수 있는? 기능 빼주기
        collectionView.alwaysBounceVertical = false
            
        // pageControl에 컨텐츠 개수만큼 넣기
        pageControl.numberOfPages = bannerInfos.count
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        // 섹션 너비에 구애받지 않고 가로로 나열하겠다
        // 가운데 정렬로 페이징 촥촥
        section.orthogonalScrollingBehavior = .groupPagingCentered
        // 그룹간 띄우기
        section.interGroupSpacing = 20
        // pageControl과 연결하기 위한 인덱스 구하는 클로저
        section.visibleItemsInvalidationHandler = { (item, offset, env) in
            // 각 컨텐츠의 인덱스 값 구하기 => 소수점 반올림
            let index = Int((offset.x/env.container.contentSize.width).rounded(.up))
            //print(index) // 0, 1, 2, 3 확인 완료!
            self.pageControl.currentPage = index
        }
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}
