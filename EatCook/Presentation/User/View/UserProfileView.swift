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
                    requestManager: NetworkManager()))))
    
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
                            Text("\(viewModel.myPageData.follower)")
                                .fontWeight(.semibold)
                            
                            Text("팔로워")
                        }
                        .frame(width: 110)
                        //                    .background(.red)
                        
                        Spacer()
                        
                        VStack(spacing: 12) {
                            Text("\(viewModel.myPageData.following)")
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
                        Rectangle()
                            .frame(width: 96, height: 96)
                            .foregroundStyle(.gray5)
                        //                .resizable()
                        //                .scaledToFill()
                        //                .frame(width: 96, height: 96)
                            .clipShape(Circle())
                        
                        Text(viewModel.myPageData.nickName)
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        BadgeTitleView(badgeLevel: BadgeTitleView.checkBadgeLevel(viewModel.myPageData.posts.content.count))
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
                        ForEach(viewModel.myPageContentsData, id: \.id) { item in
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
            viewModel.responseMyPage(0)
        }
        
    }
}

#Preview {
    NavigationStack {
        UserProfileView()
            .environmentObject(NavigationPathFinder.shared)
    }
    
}
