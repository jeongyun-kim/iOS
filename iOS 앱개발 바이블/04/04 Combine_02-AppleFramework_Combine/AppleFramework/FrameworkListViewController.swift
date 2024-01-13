//
//  FrameworkListViewController.swift
//  AppleFramework
//
//  Created by joonwon lee on 2022/04/24.
//

import UIKit
import Combine

class FrameworkListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias Item = AppleFramework
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
//    let list: [AppleFramework] = AppleFramework.list
    
    // Combine
    var subscriptions = Set<AnyCancellable>()
    let didSelect = PassthroughSubject<AppleFramework, Never>() // 선택이 되었을 때 선택이 된 걸 인지
    let items = CurrentValueSubject<[AppleFramework], Never>(AppleFramework.list)
    
    // Data, Presentation, Layout
    override func viewDidLoad() {
        super.viewDidLoad()
        // CollectionView Presentation, Layout 설정해주는 것
        configureCollectionView()
        // CollectionView 그리는데 필요한 Data 설정해주는 것
        bind()
    }
    
    // 사용자 input / output 관리
    private func bind() {
        // input : 사용자 input을 받아 처리해야 할 것
        // - item 선택되었을 때 처리
        didSelect // didSelect가 publisher -> sb, vc 등이 subscriber
            .receive(on: RunLoop.main) // UI 변경이니까 main 스레드에서 일어나도록 해주기
            .sink { [unowned self] framework in // didSelect에서 framework 받아오고
                // 그에 따른 viewController를 찾아와서 선택된 framework를 세팅해주고
                let sb = UIStoryboard(name: "Detail", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "FrameworkDetailViewController") as! FrameworkDetailViewController
                vc.framework.send(framework) // 디테일뷰에 framework 보내기
                //vc.framework = framework
                // 띄우는 작업까지
                present(vc, animated: true)
            }.store(in: &subscriptions)
        // output: data, state 변경에 따라, UI 업데이트 할 것
        // - items가 세팅이 되었을 때, collectionView를 업데이트(applySectionItems 불러오기)
        // - publisher : list -> subscriber : applySectionItems
        items
            .receive(on: RunLoop.main) // main thread에서 작동하게 해줌
            .sink{ [unowned self] list in // closure안에 실행한 것이기 때문에 self
                applySectionItems(list)
            }.store(in: &subscriptions)
        
    }
    
    // data
    // 아이템 받아서 어떤 섹션에 적용하겠다 default는 메인
    private func applySectionItems(_ items: [Item], to section: Section = .main) {
        // data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([section])
        snapshot.appendItems(items, toSection: .main)
        dataSource.apply(snapshot)
    }
    // presentation & layout
    private func configureCollectionView() {
        // presentation
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrameworkCell", for: indexPath) as? FrameworkCell else {
                return nil
            }
            cell.configure(item)
            return cell
        })
        // layer
        collectionView.collectionViewLayout = layout()
        
        collectionView.delegate = self
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let spacing: CGFloat = 10
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalWidth(0.33))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.33))
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: itemLayout, count:   3)
        groupLayout.interItemSpacing = .fixed(spacing)
        
        // Section
        let section = NSCollectionLayoutSection(group: groupLayout)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        section.interGroupSpacing = spacing
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

// item 선택되었을 때 처리
extension FrameworkListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // didSelect 되고 나서 그거에 대한 item을 framework로 가져오고
        let framework = items.value[indexPath.item]
        print(">>> selected: \(framework.name)")
        
        didSelect.send(framework) // publisher(didSelect)에 데이터 보내기
    }
}
