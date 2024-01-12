//: [Previous](@previous)

import Foundation
import Combine
import UIKit

// Transform - Map
let numPublisher = PassthroughSubject<Int, Never>()
let subscription1 = numPublisher
    .map { $0 * 2 }
    .sink { value in
        print("Transformed Value: \(value)")
    }
numPublisher.send(10) // Transformed Value: 20
numPublisher.send(20) // Transformed Value: 40
numPublisher.send(30) // Transformed Value: 60
subscription1.cancel()


// Filter
let stringPublisher = PassthroughSubject<String, Never>()
let subscription2 = stringPublisher
    .filter { $0.contains("a") }
    .sink { value in
        print("Filtered Value: \(value)")
    }
stringPublisher.send("abc") // Filtered Value: abc
stringPublisher.send("ccc")
stringPublisher.send("cocoa") // Filtered Value: cocoa
subscription2.cancel()
