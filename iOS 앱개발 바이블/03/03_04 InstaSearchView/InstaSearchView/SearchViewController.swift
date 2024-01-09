import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    // Data, Presentation, Layout
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
    
        if let flowlayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            // 시스템이 사이즈 건드리지 않게
            flowlayout.estimatedItemSize = .zero
        }
        
        // 서치바 구성
        self.navigationItem.title = "Search"
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "검색어를 입력하세용"
        searchController.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCell", for: indexPath)as? ResultCell else {
            return UICollectionViewCell()
        }
        let imageName = "animal\(indexPath.item+1)"
        cell.configure(imageName)
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 이미지간 좌우 간격
        let interItemSpacing: CGFloat = 1
        // 가로 너비
        let width = (collectionView.bounds.width - interItemSpacing*2) / 3
        // 세로 정사각형으로 할거라 width랑 같음
        let height = width
        
        return CGSize(width: width, height: height)
    }
    
    // 좌우 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // 상하 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  1
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let search = searchController.searchBar.text
        print("검색어 : \(search)")
    }
}
