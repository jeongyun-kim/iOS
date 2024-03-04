//
//  HomeViewController.swift
//  TossBenefitTab
//
//  Created by 김정윤 on 1/2/24.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    // 2. collectionView 연결
    @IBOutlet weak var collectionView: UICollectionView!
    // 3. Section 정의
    enum Section: Int {
        case today
        case other
    }
    // 4. Item 정의 : Hashable인 어떤 모델이든 들어올 수 있음
    typealias Item = AnyHashable
    // 5. datasource 정의 : DiffableDataSource 맨 뒤에 ! 필수
    var datasource: UICollectionViewDiffableDataSource<Section, Item>!
    // 6. todaySectionItems : todaySection에 들어갈 아이템 정해주기 -> 내 포인트, 오늘의 혜택 -> 2개라 배열로 묶어서 표현
    @Published var todaySectionItems: [AnyHashable] = [MyPoint.default, Benefit.today]
    // 7. otherSectionItems : otherSection에 들어갈 아이템 넣어주기 -> Benefits.others
    @Published var otherSectionItems: [AnyHashable] = [Benefit.others]
    // subscription 저장할 곳
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureCollectionView()
        
       
        
       //combine으로 연결한 데이터 불러오기
        bind()
    }
    
    private func setupUI() {
        // 내비게이션 타이틀 지정
        navigationItem.title = "혜택"
        
    }
    private func configureCollectionView() {
        // 8. ❗️presentation : datasource 이용해서 화면 보여주기
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            // 섹션 정의하기
            guard let section = Section(rawValue: indexPath.section) else { return nil }
            // 셀 정의하기
            let cell = self.configureCell(for: section, item: item, collectionView: collectionView, indexPath: indexPath)
            return cell
        })
        
        // 9. ❗️data : 받아온 데이터 세팅하기 -> snapshot 이용
//        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
//        snapshot.appendSections([.today, .other]) // 섹션 삽입
//        // today 섹션에 today 관련 아이템 삽입
//        snapshot.appendItems(todaySectionItems, toSection: .today)
//        // other 섹션에 other 관련 아이템 삽입
//        snapshot.appendItems(otherSectionItems, toSection: .other)
//        // datasource에 snapshot 보내기
//        datasource.apply(snapshot)
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.today, .other])
        snapshot.appendItems([], toSection: .today)
        snapshot.appendItems([], toSection: .other)
        datasource.apply(snapshot)
        
        // 10. ❗️layout 그리기
        collectionView.collectionViewLayout = layout()
        
        // 12. click 감지
        collectionView.delegate = self
    }
    
    // 9. 셀 구성하는 함수
    // - for Section: 해당 데이터를 넣을 섹션
    // - item : 어떤 아이템을 쓸 건지
    // - collectionView : 사용할 컬렉션뷰
    // - indexPath : 몇 번째 섹션에 들어가는지
    private func configureCell(for section: Section, item: Item, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell? {
        switch section {
        case .today:
            if let point = item as? MyPoint {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PointCell", for: indexPath) as! PointCell
                cell.configure(point: point)
                return cell
            } else if let benefit = item as? Benefit {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayCell", for: indexPath) as! TodayCell
                cell.configure(item: benefit)
                return cell
            } else {
                return nil
            }
        case .other:
            if let other = item as? Benefit {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BenefitCell", for: indexPath) as! BenefitCell
                cell.configure(item: other)
                return cell
            } else {
                return nil
            }
        }
    }
    
    // 11. ❗️layout 함수
    private func layout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 0, trailing: 16)
        section.interGroupSpacing = 10
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    // 14. combine 사용하는 함수
    private func bind() {
        $todaySectionItems
            .receive(on: RunLoop.main)
            .sink { item in
               
            }

        
    }
}

// 13. click 감지, item 사용하기 위해 extension
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = datasource.itemIdentifier(for: indexPath)
        print("item : \(item)")
    }
}
