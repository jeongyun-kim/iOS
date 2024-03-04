//
//  MyPoint.swift
//  TossBenefitTab
//
//  Created by 김정윤 on 1/2/24.
//

import Foundation

struct MyPoint: Hashable {
    var point: Int
}

extension MyPoint {
    static let `default` = MyPoint(point: 0)
}
