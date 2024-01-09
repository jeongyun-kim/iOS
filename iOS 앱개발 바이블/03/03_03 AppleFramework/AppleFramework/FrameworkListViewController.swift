import UIKit

class FrameworkListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let list: [AppleFramework] = AppleFramework.list
    
    // data, presentation, layout
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self // layout관련해서도 위임을 하지만 클릭된것에 대해서도 위임을 함
        
        navigationController?.navigationBar.topItem?.title = "😍 Apple Framework~!"
        
        // Collection View의 estimate size를 속성으로 none 처리 할 수 있던걸 코드로도 가능
        if let flowlayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            flowlayout.estimatedItemSize = .zero
        }
        
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 16, bottom: 0, right: 16)
    
    }
}

extension FrameworkListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrameworkCell", for: indexPath) as? FrameworkCell else {
            return UICollectionViewCell()
        }
        
        let framework = list[indexPath.item]
        cell.configure(framework)
        return cell
    }
}

extension FrameworkListViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀 간 간격 10, 한 줄당 세 항목
        
        // 셀 사이 간격 주기
        let interItemSpacing: CGFloat = 10
        let padding: CGFloat = 16
        
        // 가로길이에서 간격 제외하고 항목들이 차지할 가로 길이
        let width = (collectionView.bounds.width - interItemSpacing * 2 - padding * 2) / 3
        // 높이는 가로길이 * 1.5
        let height = width * 1.5
        
        return CGSize(width: width, height: height)
    }
    // 아이템 간 좌우 간격
    // 줄 간의 거리 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension FrameworkListViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let framework = list[indexPath.item]
        print(">>> selected: \(framework.name)!")
    }
}
