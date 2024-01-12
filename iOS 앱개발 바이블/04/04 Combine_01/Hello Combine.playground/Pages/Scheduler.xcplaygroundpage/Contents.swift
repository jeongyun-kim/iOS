//: [Previous](@previous)

import Foundation
import Combine
import UIKit

// Scheduler
let arrPublisher = [1, 2, 3].publisher
let queue = DispatchQueue(label: "custom")
let subscription = arrPublisher
    .subscribe(on: queue)
    .map { value -> Int in // 메인스레드에서 돌아가던걸 커스텀 스레드에서 돌아가도록 하고싶음!
        print("transform: \(value), thread: \(Thread.current)")
        return value
    }
    .receive(on: DispatchQueue.main)
    .sink { value in
    print("Received Value: \(value), thread: \(Thread.current)")
}
