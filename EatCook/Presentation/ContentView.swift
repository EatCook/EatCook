//
//  ContentView.swift
//  EatCook
//
//  Created by 이명진 on 2/6/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var naviPathFinder: NavigationPathFinder
    @State private var selectedTab: Int = 0
    
    var body: some View {
        NavigationStack(path: $naviPathFinder.path) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                        
                        Text("홈").foregroundColor(.gray5)
                    }
                    .tag(0)
                
                FeedView()
                    .tabItem {
                        Image(.tabViewCookTalk).renderingMode(.template)
                        Text("쿡Talk").foregroundColor(.gray5)
                    }
                    .tag(1)
                
                UserProfileView()
                    .tabItem {
                        Image(systemName: "person")
                        
                        Text("마이페이지").foregroundColor(.gray5)
                    }
                    .tag(2)
            }
//            .navigationTitle(titleForNavigationTitle())
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: ViewOptions.self) { viewCase in
                viewCase.view()
            }
        }
        
    }
    
    private func titleForNavigationTitle() -> String {
        switch selectedTab {
        case 0: return ""
        case 1: return "쿡Talk"
        case 2: return ""
        default: return ""
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(NavigationPathFinder.shared)
    
}
