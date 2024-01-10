//
//  FocusViewController.swift
//  HeadSpaceFocus
//
//  Created by 김정윤 on 11/27/23.
//

import UIKit

class FocusViewController: UIViewController {
    var curated: Bool = false

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var refreshButton: UIButton!

    // 데이터 불러오기
    var  items: [Focus] = Focus.list
    
    typealias Item = Focus // Item은 Focus의 별칭(typealias)
    enum Section { // 단일 섹션 형태
        case main
    }
    // 섹션타입, 아이템 타입 정해주기
    var datasource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 버튼 둥글게
        refreshButton.layer.cornerRadius = 10
        
        // presentation
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FocusCell", for: indexPath) as? FocusCell else {
                    return nil
                }
            cell.configure(item)
            return cell
        })

        // data : snapshot을 만들기 => 이 정보말고는 가짜야!
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main) // 아이템들을 메인섹션에 넣을거다
        datasource.apply(snapshot) // datasource로 스냅샷 보내기
        
        // layout 함수 적용
        collectionView.collectionViewLayout = layout()
        
        updateButtonTitle()
    }
    // layout 함수
    private func layout() -> UICollectionViewCompositionalLayout {
        // estimated : 50사이즈라고 예상하는데 아닐수도 있다~ 동적으로 적용됨
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        section.interGroupSpacing = 10 // 그룹간의 띄기
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    // 버튼 눌렀을 때 버튼 텍스트 변경
    func updateButtonTitle() {
        let title = curated ? "See All" : "See Recommendation"
        refreshButton.setTitle(title, for: .normal)
    }
    // 버튼 눌렀을 때 액션 설정
    @IBAction func refreshButtonTapped(_ sender: Any) {
        curated.toggle() // toggle을 누르면 true가 false로, false가 true로
        self.items = curated ? Focus.recommendations : Focus.list
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        datasource.apply(snapshot)
    
        updateButtonTitle()
    }
}
