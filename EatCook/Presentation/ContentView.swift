//
//  ContentView.swift
//  EatCook
//
//  Created by 이명진 on 2/6/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    
                    Text("홈")
                }
            
            FeedView()
                .tabItem {
                    Image(systemName: "fork.knife")
                    
                    Text("쿡Talk")
                }
            
            Text("마이페이지")
                .tabItem {
                    Image(systemName: "person")
                    
                    Text("마이페이지")
                }
        }
    }
    
}


#Preview {
    ContentView()
}
