//: [Previous](@previous)

import Foundation
import Combine

// Subscription : Subscriber와 Publisher가 연결됨을 나타냄
let subject = PassthroughSubject<String, Never>()

let subscription = subject
    .print()
    .sink { value in
        print("subscriber received value: \(value)")
}
subject.send("hello")
subject.send("hello again")
subject.send("hello for the last time")
//subject.send(completion: .finished) // 관계 끝 -> 이후 데이터는 출력되지 않음
subscription.cancel()
subject.send("hello ?? :(")
/*
 receive subscription: (PassthroughSubject)
 request unlimited
 receive value: (hello)
 subscriber received value: hello
 receive value: (hello again)
 subscriber received value: hello again
 receive value: (hello for the last time)
 subscriber received value: hello for the last time
 receive finished(cancel)
 */
