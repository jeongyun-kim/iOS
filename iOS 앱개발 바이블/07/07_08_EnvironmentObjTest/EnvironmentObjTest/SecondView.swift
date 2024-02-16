//
//  SecondView.swift
//  EnvironmentObjTest
//
//  Created by 김정윤 on 12/25/23.
//

import SwiftUI

struct SecondView: View {
    var body: some View {
        VStack(spacing: 20) {
        NavigationLink {
                ThirdView()
            } label: {
                Text("Third View")
            }
        }
        .navigationTitle("Second View")
        }
    }


#Preview {
    SecondView()
}
