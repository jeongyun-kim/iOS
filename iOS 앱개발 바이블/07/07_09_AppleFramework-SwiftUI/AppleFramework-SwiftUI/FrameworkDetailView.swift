//
//  FrameworkDetailView.swift
//  AppleFramework-SwiftUI
//
//  Created by 김정윤 on 12/26/23.
//

import SwiftUI

struct FrameworkDetailView: View {
    
    @StateObject var viewModel: FrameworkDetailViewModel
    
//    @Binding var framework: AppleFramework?
//    // 앞의 뷰를 띄우면 presentationMode를 이용해 상태가 넘어옴
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 20) {
            
            Spacer()
            
            Image(viewModel.framework.imageName)
                .resizable()
                .frame(width: 90, height: 90)
            Text(viewModel.framework.name)
                .font(.system(size: 24, weight: .bold, design: .default))
            Text(viewModel.framework.description)
                .font(.system(size: 16, weight: .regular))
        
            Spacer()
           
            Button {
                print("Safari 띄우기")
                viewModel.isSafariPresented = true
            } label: {
                Text("Learn More")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .foregroundColor(.white)
            }.frame(maxWidth: .infinity, minHeight: 80)
                .background(.pink)
                .cornerRadius(40)
        }.padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
        // safari 띄우기
        .sheet(isPresented: $viewModel.isSafariPresented) {
            let url = URL(string: viewModel.framework.urlString)!
            SafariView(url: url)
        }

    }
}

#Preview {
    // binding 된 데이터 꽂아줄 때는 constant 이용
    FrameworkDetailView(viewModel: FrameworkDetailViewModel(framework: AppleFramework.list[0]))
}
