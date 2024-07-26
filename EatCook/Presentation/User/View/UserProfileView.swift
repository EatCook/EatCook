//
//  UserProfileView.swift
//  EatCook
//
//  Created by 이명진 on 2/8/24.
//

import SwiftUI

enum UserProfileTabCase: CaseIterable {
    case mypage
    case storagebox
    
    var title: String {
        switch self {
        case .mypage:
            return "마이페이지"
        case .storagebox:
            return "보관함"
        }
    }
    
    var index: Int {
        return UserProfileTabCase.allCases.firstIndex(of: self) ?? 0
    }
    
    var count: Int {
        return UserProfileTabCase.allCases.count
    }
    
    @ViewBuilder
    func tabCaseContainerView() -> some View {
        switch self {
        case .mypage: UserProfileContainerView(tabCase: .mypage)
        case .storagebox: UserProfileContainerView(tabCase: .storagebox)
        }
    }
    
}

struct UserProfileView: View {
    @State private var activeTab: UserProfileTabCase = .mypage
    @Namespace private var animation
    
    @StateObject private var viewModel = UserProfileViewModel(
        myPageUseCase: MyPageUseCase(
            eatCookRepository: EatCookRepository(
                networkProvider: NetworkProviderImpl(
                    requestManager: NetworkManager()))),
        loginUserInfo: LoginUserInfoManager.shared)
    
    @EnvironmentObject private var naviPathFinder: NavigationPathFinder
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 0) {
                UserProfileTopView {
                    naviPathFinder.addPath(.setting)
                }
                
                ZStack(alignment: .top) {
                    HStack(alignment: .center) {
                        Spacer()
                            .frame(width: 16)
                        
                        VStack(spacing: 12) {
                            Text("\(viewModel.myPageUserInfo.followerCounts)")
                                .fontWeight(.semibold)
                            
                            Text("팔로워")
                        }
                        .frame(width: 110)
                        
                        Spacer()
                        
                        VStack(spacing: 12) {
                            Text("\(viewModel.myPageUserInfo.followingCounts)")
                                .fontWeight(.semibold)
                            
                            Text("팔로잉")
                        }
                        .frame(width: 110)
                        
                        Spacer()
                            .frame(width: 16)
                    }
                    .padding(.vertical, 20)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .offset(y: -12)
                    //                .background(.gray)
                    
                    VStack(spacing: 12) {
                        if let imageUrlString = viewModel.myPageUserInfo.userImagePath {
                            let imageUrl = URL(string: "\(Environment.AwsBaseURL)/\(imageUrlString)")
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                    .frame(width: 96, height: 96)
                                    .scaledToFit()
                                    .clipShape(Circle())
//                                    .padding(.top, 24)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 96, height: 96)
                            }
                        } else {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 130, height: 130)
                                .scaledToFit()
                                .clipShape(Circle())
                                .padding(.top, 24)
                                .foregroundStyle(.gray3)
                        }
//                        Rectangle()
//                            .frame(width: 96, height: 96)
//                            .foregroundStyle(.gray5)
//                            .clipShape(Circle())
                        
                        Text(viewModel.myPageUserInfo.nickName)
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        BadgeTitleView(badgeLevel: BadgeTitleView.checkBadgeLevel(viewModel.myPageMyRecipeData.count))
                    }
                    .offset(y: -50)
                }
                
                VStack {
                    HStack {
                        ForEach(UserProfileTabCase.allCases, id: \.self) { tabCase in
                            Button {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    activeTab = tabCase
                                }
                            } label: {
                                Text(tabCase.title)
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundStyle(activeTab == tabCase ? .primary6 : .gray4)
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 16)
                            }
                            .overlay(alignment: .bottom) {
                                if activeTab == tabCase {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(.primary6)
                                        .frame(height: 3)
                                        .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .background {
                        Rectangle()
                            .fill(.gray1)
                            .frame(height: 1)
                            .offset(y: 20)
                    }
                    
                    if activeTab == .mypage {
                        ForEach(viewModel.myPageMyRecipeData, id: \.id) { item in
                            UserProfileRowView(myPageContentData: item)
                        }
                    } else {
                        UserProfileStorageView(viewModel: viewModel)
                    }
                    
                }
                .padding(.bottom, 100)
            }
            
        }
        .ignoresSafeArea()
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.responseMyPage()
            viewModel.responseMyPageMyRecipe()
        }
        
    }
}

#Preview {
    NavigationStack {
        UserProfileView()
            .environmentObject(NavigationPathFinder.shared)
    }
    
}
