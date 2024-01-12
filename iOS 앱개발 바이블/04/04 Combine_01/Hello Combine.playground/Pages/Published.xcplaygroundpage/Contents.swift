//: [Previous](@previous)

import Foundation
import Combine
import UIKit

// @Published : class에서만 사용 가능
final class SomeViewModel {
    @Published var name: String = "DDAEZI"
    var age: Int = 20
}
final class Label {
    var text: String = ""
}
let label = Label()
let vm = SomeViewModel()
print("text: \(label.text)")
// $ : Publisher -> Subscription 관계 생성
// label이 vm의 name을 구독
vm.$name.assign(to: \.text, on: label)
print("text: \(label.text)")
/*
 text:
 text: DDAEZI
 */

// viewmodel의 name을 바꿀때마다 이 viewmodel을 구독중인 Label의 텍스트가 바뀌는 것을 확인할 수 있음!!
vm.name = "DZ"
print("text: \(label.text)") // text: DZ
vm.name = "Hoo"
print("text: \(label.text)") // text: Hoo
