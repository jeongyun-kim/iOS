import UIKit

class ChatListViewController: UIViewController {
    // 컬렉션뷰 정의
    @IBOutlet weak var collectionView: UICollectionView!
    // 채팅리스트 가져오기
    var chatList: [Chat] = Chat.list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // data, presentation, layout
        // : 담당자는 결국 ChatListViewController
        
        collectionView.dataSource = self
        collectionView.delegate = self

        // 채팅리스트의 채팅을 두 개씩 비교해서 1번의 채팅이 2번의 채팅보다 날짜가 크게 해
        // 항상 이 조건에 참이 되도록 변경해
        chatList = chatList.sorted(by: { chat1, chat2 in
            return chat1.date > chat2.date
        })
    }

}

extension ChatListViewController: UICollectionViewDataSource{
    // 보여줄 컨텐츠의 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatListCollectionViewCell", for: indexPath) as? ChatListCollectionViewCell else {
            return UICollectionViewCell()
        }
        let chat = chatList[indexPath.item]
        cell.configure(chat)
        return cell
        }
}

// layout에 대한 권한 위임
extension ChatListViewController: UICollectionViewDelegateFlowLayout{
    // 너비는 컬렉션뷰 자체, 높이는 100정도
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 100)
    }
}
