
//
//  FeedView.swift
//  EatCook
//
//  Created by 이명진 on 2/7/24.
//

import SwiftUI


enum CookTalkTabCase: CaseIterable {
    case cooktalk
    case follow
    
    var title: String {
        switch self {
        case .cooktalk: return "쿡톡"
        case .follow: return "팔로우"
        }
    }
    
    var index: Int {
        return CookTalkTabCase.allCases.firstIndex(of: self) ?? 0
    }
    
    var count: Int {
        return CookTalkTabCase.allCases.count
    }
    
//    @ViewBuilder
//    func tabCaseContainerView(_ viewModel: FeedViewModel) -> some View {
//        switch self {
//        case .cooktalk: FeedContainerView(viewModel: viewModel, feedType: .cooktalk)
//        case .follow: FeedContainerView(viewModel: viewModel, feedType: .follow)
//        }
//        
//    }
}

struct FeedView: View {
    @State private var activeTab: CookTalkTabCase = .cooktalk
    @Namespace private var animation
    //    @State private var offsetX: CGFloat = 0
    @EnvironmentObject private var naviPathFinder: NavigationPathFinder
    
    @StateObject private var viewModel = FeedViewModel(
        useCase: CookTalkUseCase(
            eatCookRepository: EatCookRepository(
                networkProvider: NetworkProviderImpl(
                    requestManager: NetworkManager()))))
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let tabWidth = size.width / CGFloat(CookTalkTabCase.allCases.count)
            
            ZStack(alignment: .bottomTrailing) {
                VStack(spacing: 0) {
                    HStack {
                        Text("쿡Talk")
                            .font(.system(size: 24, weight: .semibold))
                            .padding(.vertical, 14)
                            .padding(.horizontal, 16)
                        
                        Spacer()
                    }
                    .frame(height: 44)
                    
                    /// TabIndicator
                    HStack(alignment: .center, spacing: 0) {
                        ForEach(CookTalkTabCase.allCases, id: \.self) { tabCase in
                            Button {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    activeTab = tabCase
                                }
                            } label: {
                                Text(tabCase.title)
                                    .font(.headline)
                                    .fontWeight(activeTab == tabCase ? .bold : .semibold)
                                    .foregroundStyle(activeTab == tabCase ? .black : .gray)
                                    .frame(width: tabWidth - 80)
                                    .padding(.vertical, 12)
                            }
                            .overlay(alignment: .bottom) {
                                if activeTab == tabCase {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill()
                                        .frame(height: 3)
                                        .padding(.horizontal, 20)
                                        .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                                    //                                    .animation(.easeInOut(duration: 0.3), value: activeTab)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .background {
                        Rectangle()
                            .fill(.gray)
                            .frame(height: 1)
                            .offset(y: 20)
                    }
                    
                    /// TabView
                    TabView(selection: $activeTab) {
                        ScrollView(.vertical, showsIndicators: true) {
                            LazyVStack {
                                ForEach(viewModel.feedData, id: \.postId) { item in
                                    FeedRowView(cookTalkFeedData: item)
                                        .onTapGesture {
                                            naviPathFinder.addPath(.recipeDetail(item.postId))
                                        }
                                }
                                if viewModel.feedDataHasNextPage {
                                    ProgressView()
                                        .onAppear {
                                            viewModel.responseCookTalkFeed(viewModel.feedDataCurrentPage + 1)
                                        }
                                }
                            }
                        }
                        .tag(CookTalkTabCase.cooktalk)
                        
                        ScrollView(.vertical, showsIndicators: true) {
                            LazyVStack {
                                ForEach(viewModel.followData, id: \.postId) { item in
                                    FollowRowView(cookTalkFollowData: item)
                                        .onTapGesture {
                                            naviPathFinder.addPath(.recipeDetail(item.postId))
                                        }
                                }
                                if viewModel.followDataHasNextPage {
                                    ProgressView()
                                        .onAppear {
                                            viewModel.responseCookTalkFollow(viewModel.followDataCurrentPage + 1)
                                        }
                                }
                            }
                        }
                        .tag(CookTalkTabCase.follow)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .background(.gray1)
                    .onAppear {
                        viewModel.responseCookTalkFeed(viewModel.feedDataCurrentPage)
                        viewModel.responseCookTalkFollow(viewModel.followDataCurrentPage)
                    }
                }
                
                Button {
                    naviPathFinder.addPath(.recipeCreate(""))
                } label: {
                    Image("plusbutton")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 48, height: 48)
                        .offset(x: -16, y: -16)
                }
                
            }
            
        }
    }
}

#Preview {
    NavigationStack {
        FeedView()
            .environmentObject(NavigationPathFinder.shared)
    }
}
