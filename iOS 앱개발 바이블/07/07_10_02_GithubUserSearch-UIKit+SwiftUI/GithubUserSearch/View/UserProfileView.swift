//
//  UserProfileView.swift
//  GithubUserSearch
//
//  Created by 김정윤 on 12/26/23.
//

import SwiftUI
import Kingfisher

struct UserProfileView: View {
    
    //var userProfile: UserProfile
    
    @StateObject var viewModel: UserProfileViewModel
    
    var body: some View {
        VStack(spacing: 60) {
            KFImage(viewModel.imageUrl)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 160, height: 160)
                .background(.gray)
                .cornerRadius(80)
            VStack(alignment: .leading, spacing: 40) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(viewModel.name)
                        .font(.system(size: 24, weight: .bold, design: .default))
                    Text(viewModel.loginId)
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text(viewModel.followers)
                    Text(viewModel.following)
                }
                .font(.system(size: 18))
                .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
        }.onAppear {
            let id = viewModel.loginId
            viewModel.search(keyword: id)
        }
    }
}

#Preview {
    // 임의 계정 불러오기(cafielo)
    //UserProfileView(userProfile: UserProfile.mock)
    
    UserProfileView(viewModel: UserProfileViewModel(network: NetworkService(configuration: .default), loginId: "jeongyun-kim"))
}
