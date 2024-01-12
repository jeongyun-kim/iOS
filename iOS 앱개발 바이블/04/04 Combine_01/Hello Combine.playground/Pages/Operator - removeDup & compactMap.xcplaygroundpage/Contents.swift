//: [Previous](@previous)

import Foundation
import Combine
import UIKit

var subscription = Set<AnyCancellable>()

// removeDuplicates
let words = "hey hey there! Mr Mr ?"
    .components(separatedBy: " ") // ["hey", "hey", "there!", "Mr", "Mr", "?"]
    .publisher
words
    .removeDuplicates() // 중복 제거
    .sink { value in
        print(value)
    }.store(in: &subscription) // 미리 만들어둔 subscription에 넣어도 됨
/*
 hey
 there!
 Mr
 ?
 */


// compactMap
let strings = ["a", "1.24", "3", "def", "45", "0.23"].publisher

strings
    .compactMap { Float($0) } // compactMap : nil 아닌 값 들고옴
    .sink { value in
        print(value)
    }.store(in: &subscription)
/*
 1.24
 3.0
 45.0
 0.23
 */


// ignoreOutput : 더 이상 publisher에 대해서 알 필요없어서 무시해야할 때
let numbers = (1...10_000).publisher // 1부터 10,000까지의 데이터

numbers
    .ignoreOutput()
    .sink(receiveCompletion: { print("Completed with: \($0)")}, receiveValue: { print($0) })
    .store(in: &subscription)
// Completed with: finished


// prefix
let tens = (1...10).publisher // 1부터 10까지의 데이터

tens
    .prefix(2) // 앞의 2개는 가져오기
    .sink(receiveCompletion: { print("Completed with: \($0)") }, receiveValue: { print($0) })
    .store(in: &subscription)
/*
 1
 2
 Completed with: finished
 */
