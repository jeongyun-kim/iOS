
import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let messages: [OnboardingMessage] = OnboardingMessage.messages
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        // 페이지 컨트롤 개수
        pageControl.numberOfPages = messages.count
        // 시작 페이지 번호
        pageControl.currentPage = 0
    }
}

extension OnboardingViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as? OnboardingCell else {
            return UICollectionViewCell()
        }
        let message = messages[indexPath.item]
        cell.configure(message)
        return cell
    }
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // width, height 둘 다 가짐
        return collectionView.bounds.size
    }
    // 간격 0으로
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}

// 현재 스크롤뷰의 상황을 파악할 수 있음
extension OnboardingViewController: UIScrollViewDelegate {
    // 스크롤 이동 시 offset값을 볼 수 있음
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(Int(scrollView.contentOffset.x / self.collectionView.bounds.width))
//    }
    
    // 감속하면서 멈추었단거 확인 가능
    // => 인덱스 값을 줘서 페이지컨트롤 업데이트
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / self.collectionView.bounds.width)
        
        pageControl.currentPage = index
    }
}
