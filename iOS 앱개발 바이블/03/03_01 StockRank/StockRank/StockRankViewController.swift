import UIKit
// 주황색 표시일때 커맨드 옵션 플러스 하면 바로 적용
class StockRankViewController: UIViewController {
    
    let stockList: [StockModel] = StockModel.list
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // data, presentation, layout
    // data : 어떤 데이터? -> stockList
    // presentation : 셀을 어떻게 표현?
    // layout : 셀을 어떻게 배치할지?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 아래 둘은 프로토콜 즉, 수행해야하는 규칙이 있음
        // 알려주는 대상이 누구냐 = self
        // 알려줘야하는 메서드들이나 프로퍼티들을 알려주는 행위가 필요
        collectionView.dataSource = self
        collectionView.delegate = self
        
   
    }
}

extension StockRankViewController: UICollectionViewDataSource{
    // 데이터 몇 개나 들어오는지 답하는 함수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stockList.count
    }
    // 컬렉션뷰에서 셀을 어떻게 표현할지 답하는 함수
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 컬렉션 뷰에 등록된 재사용 가능한 셀을 가져오겠다
        // 여러 개면 identifier을 통해 가져올 수 있음
        // 몇 번째에 해당하는 녀석의 셀을 가져올 것이냐
        // 가져온 셀을 StockRankCollectionViewCell로 캐스팅해줌
        // 제대로 언랩핑되면 아래 코드들을 실행하고 아니면 일반적인 셀을 리턴
        
        // ! guard 꼭 참이어야하는 조건 else { } 참이면 실행되는 코드~
        
        // ! casting : 나는 여자면서 사람 -> 여자라는 객체는 사람을 상속받음
        // let jeongyun = girl() 여자이기도 하면서 사람이기도 함
        // let jeongyun = human() 이면 사람인건 알겠는데 여자인지 궁금함
        // jeongyun as? girl 정윤이 여자야?하고 물어보는데, 아닐수도 있어서 옵셔널
        // guard let g = jeongyun as? girl else { print("남자" } print("여자")
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StockRankCollectionViewCell", for: indexPath) as? StockRankCollectionViewCell else {
            return UICollectionViewCell()
        }
        // indexPath : 섹션에 대한 정보와 섹션에 들어가는 데이터들의 Raw에 대한 정보가 있음
        // 얘가 몇 번째 아이템에 대해서 표시하려고 하는거야
        let stock = stockList[indexPath.item]
        // 우리가 꾸며준 셀의 형태로 적용
        cell.configure(stock)
        // 꾸며준 셀 반환
        return cell
       // return UICollectionViewCell()
    }
}

extension StockRankViewController: UICollectionViewDelegateFlowLayout{
    // 싱글 컬럼으로 보여주는 함수
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // width == collectionView
        // height = 80
        // collectionView.bounds 안의 width를 통해 컬렉션뷰의 너비를 가져올 수 있음
        return CGSize(width: collectionView.bounds.width, height: 80)
    }
    
}
