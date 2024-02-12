//
//  FeedView.swift
//  EatCook
//
//  Created by 이명진 on 2/7/24.
//

import SwiftUI

enum CookTalkTabCase: String, CaseIterable {
    case cooktalk = "쿡Talk"
    case follow = "팔로우"
    
    var tabId: String {
        return self.rawValue
    }
}

struct FeedView: View {
    @State private var activeTab: CookTalkTabCase = .cooktalk
    @Namespace private var animation
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        Section {
                            ForEach(1...10, id: \.self) { _ in
                                feedRowView()
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                            }
                        } header: {
                            tabView()
                        }
                    }
                    .background(Color("BackGround"))
                }
                
                Button {
                    
                } label: {
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
//                .background(.red)
                
            }
            .navigationTitle("쿡Talk")
            .navigationBarTitleDisplayMode(.large)
            
        }
        
    }
    
    @ViewBuilder
    func feedRowView() -> some View {
        VStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray)
                .frame(height: 200)
            
            HStack {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 25, height: 25)
                    
                Text("Username")
                    .font(.body)
                    .fontWeight(.semibold)
                
                Button {
                    
                } label: {
                    Text("팔로우")
                }
            }
            
            Text("오늘 냉장고 재료로 만든 요리는 바질 치킨 스테이크! 가뜩이나 약속도 없는데 집에서 혼자 배달시켜 먹을까 생각하다가, 크리스마스인 오늘 만큼은 나에게 대접하고 싶은 마음ㅎ_ㅎ 나도 크리스마스에 분위기 낼 수 있다구! 마침 집에 먹다 남은 치킨이 있길래, 치킨 남은거에 바질 사다가 바질 스테이크 해먹었다~")
                .font(.caption)
        }
        .padding(8)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)
        }
    }
    
    @ViewBuilder
    func tabView() -> some View {
        HStack {
            ForEach(CookTalkTabCase.allCases, id: \.rawValue) { tabCase in
                Text(tabCase.rawValue)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .background(alignment: .bottom) {
                        if activeTab == tabCase {
                            Capsule()
                                .fill(.black)
                                .frame(height: 3)
                                .padding(.horizontal, -5)
                                .offset(y: 10)
                        }
                    }
                    
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .background(Color.white)
        
    }
}

#Preview {
    NavigationStack {
        FeedView()
    }
}
