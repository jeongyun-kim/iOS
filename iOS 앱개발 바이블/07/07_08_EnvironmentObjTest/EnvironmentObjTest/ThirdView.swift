//
//  ThirdView.swift
//  EnvironmentObjTest
//
//  Created by 김정윤 on 12/25/23.
//

import SwiftUI

struct ThirdView: View {
    @EnvironmentObject var userProfile: UserProfileSetting
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Current Age : \(userProfile.age)")
            Text("Third View")
            
            Button {
                userProfile.haveBirthday()
            }label: {
                Text("Having Birthday Party!")
            }
            .navigationTitle("Third View")
        }
    }
}

#Preview {
    ThirdView().environmentObject(UserProfileSetting())
}
