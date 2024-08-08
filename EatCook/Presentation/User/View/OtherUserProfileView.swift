//
//  OtherUserProfileView.swift
//  EatCook
//
//  Created by 이명진 on 7/21/24.
//

import SwiftUI

struct OtherUserProfileView: View {
    
    @StateObject private var viewModel = OtherUserProfileViewModel(
        otherUserUseCase: OtherUserUseCase(
            eatCookRepository: EatCookRepository(
                networkProvider: NetworkProviderImpl(
                    requestManager: NetworkManager()
                )
            )
        )
    )
    
    @EnvironmentObject private var naviPathFinder: NavigationPathFinder
    
    var userId: Int
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
            } else {
                OtherUserProfileTopView(
                    otherUserData: $viewModel.otherUserInfo,
                    isFollowed: $viewModel.isFollowed
                ) {
                    viewModel.requestFollowOrUnFollow()
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("레시피")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    
                    ForEach(viewModel.otherUserPosts, id: \.id) { item in
                        OtherUserProfileRowView(otherUserPageContentData: item)
                    }
                    
                }
                .padding(.top, 32)
                .padding(.bottom, 60)
            }
        }
        .onAppear {
            Task {
                await viewModel.responseOtherUserInfo(userId)
                await viewModel.responseOtherUserPosts(userId, viewModel.page)
            }
        }
    }
}

//#Preview {
//    OtherUserProfileView()
//}
