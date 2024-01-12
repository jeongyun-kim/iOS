//: [Previous](@previous)

import Foundation
import Combine
import UIKit

// URLSessionTask Publisher and JSON Decoding Operator
// URLSessionTask : 서버에서 어떤 데이터를 받을 때, URLSession을 이용해 서버에서 데이터를 받아오는 것을 구현함
struct SomeDecodable: Decodable { }
// 특정 URL에 데이터 리퀘스트 보냄
URLSession.shared.dataTaskPublisher(for: URL(string: "https://wwww.google.com")!).map { data, response in
        return data
}
// 디코딩 : 데이터를 현재 앱 내에서 쓰고있는 객체로 바꿔줌
.decode(type: SomeDecodable.self, decoder: JSONDecoder())


// Notification
let center = NotificationCenter.default
let noti = Notification.Name("MyNoti")
let notiPublisher = center.publisher(for: noti, object: nil)
let subscription1 = notiPublisher.sink { _ in
    print("Noti Received")
}
center.post(name: noti, object: nil)
subscription1.cancel()
// Noti Received


// KeyPath binding to NSObject instances
let ageLabel = UILabel()
print("text: \(ageLabel.text)")
Just(28)
    .map { "Age is \($0)" }
    .assign(to: \.text, on: ageLabel)
print("text: \(ageLabel.text)")
/*
 text: nil
 text: Optional("Age is 28")
 */


// Timer
// autoconnect를 이용하면 subscribe 직후 자동으로 타이머가 시작됨
let timerPublisher = Timer
    .publish(every:1, on: .main, in: .common) // 1초마다 시간 출력
    .autoconnect()

let subscription2 = timerPublisher.sink { time in
    print("time: \(time)")
}
DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // 시간 출력 끝이없으니 5초까지만 출력하게 하고 끝(구독 취소)
    subscription2.cancel()
}
/*
 time: 2023-12-08 11:18:58 +0000
 time: 2023-12-08 11:18:59 +0000
 time: 2023-12-08 11:19:00 +0000
 time: 2023-12-08 11:19:01 +0000
 time: 2023-12-08 11:19:02 +0000
 */
