//
//  QuickFocusViewController.swift
//  HeadSpaceFocus
//
//  Created by 김정윤 on 12/5/23.
//

import UIKit

class QuickFocusViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let breathingList = QuickFocus.breathing
    let walkingList = QuickFocus.walking
    
    enum Section: CaseIterable{ // CaseIterable : 섹션에 포함된 모든 케이스들을 가져오고 싶을 때
        case breathing
        case walking
        
        var title: String { // 각 컬렉션뷰 별 타이틀
            switch self {
            case .breathing: return "Breathing exercises"
            case .walking: return "Mindful walks"
            }
        }
    }
    typealias Item = QuickFocus
    var datasource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // presentation
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuickFocusCell", for: indexPath) as? QuickFocusCell else {
                return nil
            }
            cell.configure(item)
            return cell
        })
        
        // 헤더뷰에 데이터 던져주기
        datasource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "QuickFocusHeaderView", for: indexPath) as? QuickFocusHeaderView else { return nil }
            let allSections = Section.allCases
            let section = allSections[indexPath.section]
            header.configure(section.title)
            return header
        }
        
        // data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.breathing, .walking]) // 섹션 넣어주기
        snapshot.appendItems(breathingList, toSection: .breathing)
        snapshot.appendItems(walkingList, toSection: .walking)
        datasource.apply(snapshot)
        
        // layout
        collectionView.collectionViewLayout = layout()
        // 라지타이틀 끄기
        self.navigationItem.largeTitleDisplayMode = .never
        
    }
    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        group.interItemSpacing = .fixed(10) // 그룹 내 아이템간의 간격

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 20, bottom: 30, trailing: 20)
        section.interGroupSpacing = 20 // 그룹간의 간격
        
        // header 생성
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    

}
