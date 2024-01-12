//: [Previous](@previous)

import Foundation
import Combine

// Subject : send를 통해서 값 보내기 가능

// PassthroughSubject
let relay = PassthroughSubject<String, Never>() // <Output type, Failure type>
let subscription1 = relay.sink { value in
        print("subscription1 received vale: \(value)")
}
relay.send("Hello")
relay.send("World")
/*
 subscription1 received vale: Hello
 subscription1 received vale: World
 */
let publisher = ["Here", "we", "go"].publisher
publisher.subscribe(relay)
/*
 ==
 relay.send("Here")
 relay.send("we")
 relay.send("go")
 */


// CurrentValueSubject
let variable = CurrentValueSubject<String, Never>("ABC") // CurrentValueSubject는 output type에 대한 초깃값이 필요
variable.send("Initial Text") // 초깃값 수정
let subscription2 = variable.sink { value in
    print("subscription2 received vale: \(value)")
}
variable.send("More text")
variable.value // 갖고있는 데이터 확인 가능 => More text
/* 들고있던 값 출력
 subscription2 received vale: ABC -> Initial Text
 subscription2 received vale: More text
 */
