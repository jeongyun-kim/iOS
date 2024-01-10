//
//  FrameworkListViewController.swift
//  AppleFramework
//
//  Created by joonwon lee on 2022/04/24.
//

import UIKit
import Combine

class FrameworkListViewController: UIViewController {
    
    // Item : 어떤 데이터 타입
    //var dataSource: UICollectionViewDiffableDataSource<Section, AppleFramework>!
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    typealias Item = AppleFramework
    // section안에 item이 여러개 [section [item]]
    enum Section {
        case main
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Combine
    // published 이용
    //@Published var list: [AppleFramework] = AppleFramework.list // published는 var
    var subscriptions = Set<AnyCancellable>()
    let didSelect = PassthroughSubject<AppleFramework, Never>()
    // subject 이용
    let items = CurrentValueSubject<[AppleFramework], Never>(AppleFramework.list)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.title = "☀️ Apple Frameworks"
        
        // Presentation / Data / Layout
        configureCollectionView()
        // input, output 처리
        bind()
    }
    
    
    private func bind() {
        // input : 사용자 인풋을 받아서 처리
        // - item 선택되었을 때 처리
        didSelect
            .receive(on: RunLoop.main)
            .sink { [unowned self] framework in
            // 우리가 띄우고 싶은 것 : FrameworkDetailViewController
            // 스토리보드에 접근 -> 디테일뷰 컨트롤러 가져오기 -> 띄우기
            let storyboard = UIStoryboard(name: "Detail", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "FrameworkDetailViewController") as! FrameworkDetailViewController
            vc.framework = framework
            present(vc, animated: true)
        }.store(in: &subscriptions)
    
        // output : data, state 변경에 따라서 UI 업데이트 할 것
        // - items가 세팅이 되었을 때, 뷰를 업데이트
        items // published의 경우, $list
            .receive(on: RunLoop.main)
            .sink { [unowned self] list in
            applySectionItems(list)
        }.store(in: &subscriptions)
    }
    
    
    // CollectionView Data 설정해주는 것
    private func applySectionItems(_ items: [Item], to section: Section = .main) {
        // Data
        // diffable datasource : presentation(snapshot), data를 담당
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([section])
        snapshot.appendItems(items, toSection: section)
        dataSource.apply(snapshot)
    }
    
    
    // CollectionView Presentation, Layout 설정해주는 것
    private func configureCollectionView() {
        // Presentation
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrameworkCell", for: indexPath) as? FrameworkCell else {
                return nil
            }
            cell.configure(item)
            // let data = datalist[indexPath.item] => let data = item
            return cell
        })
        
        // composition layout : layout담당
        // layer
        collectionView.delegate = self
        collectionView.collectionViewLayout = layout()
        
    }
    
    // Layout
    private func layout() -> UICollectionViewCompositionalLayout{
        // fractionalWidth : 할당된 사이즈 => 그룹 너비 / 3 = 0.33
        // fractionalHeight : 할당된 높이와 똑같이 하겠다!
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // 섹션의 너비를 그대로 가져다 쓰고 높이는 너비의 3분의 1정도만 써라
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.45))
        // 3등분으로 균일하게 쓰겠다
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension FrameworkListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // published의 경우
        // let framework = list[indexPath.item]
        
        // subject의 경우
        let framework = items.value[indexPath.item]
        print(">>> selected: \(framework.name)")
        
        didSelect.send(framework)
    }
}
