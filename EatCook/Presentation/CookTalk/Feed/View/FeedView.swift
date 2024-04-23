
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
    
    @ViewBuilder
    func tabCaseContainerView() -> some View {
        switch self {
        case .cooktalk: FeedContainerView()
        case .follow: Text("팔로우 피드")
        }

    }
}

struct FeedView: View {
    @State private var activeTab: CookTalkTabCase = .cooktalk

    //    @Namespace private var animation

    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ScrollView(showsIndicators: false) {

                    LazyVStack(spacing: 12, pinnedViews: [.sectionHeaders]) {
                        Section {
                            TabView(selection: $activeTab) {
                                ForEach(CookTalkTabCase.allCases, id: \.self) { tabCase in
                                    NavigationLink(destination: RecipeView().toolbarRole(.editor)) {
                                        tabCase.tabCaseContainerView()
                                            .tag(tabCase)
                                    }
                                    .tint(.primary)
                                }
                            }
                            .frame(height: 2500)
                            .tabViewStyle(.page(indexDisplayMode: .never))
                            .ignoresSafeArea(.container, edges: .bottom)
                        } header: {
                            //                        tabView()
                            FeedTabIndicatorView(activeTab: $activeTab)

                        }
                    }
                    .background(Color("BackGround"))
                }
                
                NavigationLink(destination: RecipeCreateView().toolbarRole(.editor)) {

                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundStyle(.white)
                        .background {
                            Circle()
                                .fill(.black)
                                .frame(width: 45, height: 45)
                                .shadow(color: .black, radius: 7)
                        }
                        .padding(30)
                }

            }
            .navigationTitle("쿡Talk")
            .navigationBarTitleDisplayMode(.inline)
            
        }
        

        
    }
}

#Preview {
    NavigationStack {
        FeedView()
    }
}
