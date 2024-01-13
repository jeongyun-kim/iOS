//
//  FrameworkDetailViewController.swift
//  AppleFramework
//
//  Created by joonwon lee on 2022/05/01.
//

import UIKit
import SafariServices
import Combine

class FrameworkDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //@Published var framework: AppleFramework = AppleFramework(name: "Unknown", imageName: "", urlString: "", description: "")
    let framework = CurrentValueSubject<AppleFramework, Never>(AppleFramework(name: "Unknown", imageName: "", urlString: "", description: "")) // framework publisher
    var subscriptions = Set<AnyCancellable>() // subscription 저장
    let buttonTapped = PassthroughSubject<AppleFramework, Never>() // 버튼 눌렀을 때 publisher
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        // input : 버튼을 눌렀을 때
        // framework -> url -> safari -> present
        buttonTapped // publisher
            .receive(on: RunLoop.main) // main thread에서 돌리기
            .compactMap{ URL(string: $0.urlString) } // URL로 변경, 실패하면 다음 코드 실행하지 않음
            .sink { [unowned self] url in // subscriber
                let safari = SFSafariViewController(url: url)
                self.present(safari, animated: true)
            }.store(in: &subscriptions) // subscription 잘 들고있기
        
        // output : 전달받은 프레임워크에 대해 정보를 뿌려주는 것
        framework // publisher
            .receive(on: RunLoop.main) // UI변경 -> 메인스레드
            .sink { [unowned self] framework in // subscribe
                self.imageView.image = UIImage(named: framework.imageName)
                self.titleLabel.text = framework.name
                self.descriptionLabel.text = framework.description
            }.store(in: &subscriptions) // subscription 저장
    }
    
    @IBAction func learnMoreTapped(_ sender: Any) {
        // buttonTapped publisher에 현재 framework의 데이터값들 보내기
        buttonTapped.send(framework.value)
    }
}
