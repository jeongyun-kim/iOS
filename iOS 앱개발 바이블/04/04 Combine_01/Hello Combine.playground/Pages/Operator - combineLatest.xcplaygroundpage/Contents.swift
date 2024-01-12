//: [Previous](@previous)

import Foundation
import Combine
import UIKit

// CombineLatest : 두 개의 publisher을 합치는 것, 두 publisher의 output type이 달라도 됨!

// Basic CombineLatest
let strPublisher = PassthroughSubject<String, Never>()
let numPublisher = PassthroughSubject<Int, Never>()

// strPublisher + numPublisher
// 방법 1
// Publishers.CombineLatest(strPublisher, numPublisher).sink { (str, num) in print("\(str), \(num)") }

// 방법 2
strPublisher.combineLatest(numPublisher).sink { (str, num) in
    print("Receive: \(str), \(num)")
}
//strPublisher.send("a")
//strPublisher.send("b")
//strPublisher.send("c")
//
//numPublisher.send(1)
//numPublisher.send(2)
//numPublisher.send(3)
/*
 알파벳은 가장 최근이 c이기 때문에 c출력
 Receive: c, 1
 Receive: c, 2
 Receive: c, 3
 */

strPublisher.send("a")
numPublisher.send(1)
strPublisher.send("b")
strPublisher.send("c")
numPublisher.send(2)
numPublisher.send(3)
/*
 Receive: a, 1
 Receive: b, 1
 Receive: c, 1
 Receive: c, 2
 Receive: c, 3
 */


// Advanced CombineLatest
let usernamePublisher = PassthroughSubject<String, Never>() // username
let passwordPublisher = PassthroughSubject<String, Never>() // password

let validatedCrendetialSubscription = usernamePublisher.combineLatest(passwordPublisher)
    .map { (username, password) -> Bool in // username, password가 비어있지 않고 password의 길이가 12자 이상일 때 return
        return !username.isEmpty && !password.isEmpty && password.count > 12
    }
    .sink { valid in // 닉네임과 비밀번호가 유효한 지 확인
        print("Credential valid? : \(valid)")
    }
usernamePublisher.send("DDAEZI")
passwordPublisher.send("@wjddbs0408!!")
// Credential valid? : true


// Merge : 두 publisher의 output type이 동일해야 함!
let publisher1 = [1, 2, 3, 4, 5].publisher
let publisher2 = [300, 400, 500].publisher

// 방법 1
let mergedPublisherSubscription = publisher1.merge(with: publisher2)
    .sink { value in
        print("Merge Subscription received value: \(value)")
    }

// 방법 2
//Publishers.Merge(publisher1, publisher2).sink { value in
//    print("Merge Subscription received value: \(value)")
//}

/*
 Merge Subscription received value: 1
 Merge Subscription received value: 2
 Merge Subscription received value: 3
 Merge Subscription received value: 4
 Merge Subscription received value: 5
 Merge Subscription received value: 300
 Merge Subscription received value: 400
 Merge Subscription received value: 500
 */
