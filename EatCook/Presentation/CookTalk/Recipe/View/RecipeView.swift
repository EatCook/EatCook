//
//  RecipeView.swift
//  EatCook
//
//  Created by 이명진 on 2/8/24.
//

import SwiftUI

enum RecipeTabCase: CaseIterable {
    case recipe
    case ingredients
    
    var title: String {
        switch self {
        case .recipe: return "레시피"
        case .ingredients: return "필요한 재료"
        }
    }
    
    var index: Int {
        return RecipeTabCase.allCases.firstIndex(of: self) ?? 0
    }
    
    var count: Int {
        return RecipeTabCase.allCases.count
    }
    
    @ViewBuilder
    func tabCaseContainerView() -> some View {
        switch self {
        case .recipe: RecipeContainerView()
        case .ingredients: IngredientsContainerView()
        }
    }
}

struct RecipeView: View {
    @State private var activeTab: RecipeTabCase = .recipe
    //    @Namespace private var animation
    //    @State private var contentOffset: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 12, pinnedViews: [.sectionHeaders]) {
                    HStack {
                        Circle()
                            .fill(.gray)
                            .frame(width: 25, height: 25)
                        
                        Text("Username")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        
                        Text("12.2k")
                            .font(.subheadline)
                            .foregroundStyle(.orange)
                        
                        Spacer()
                        
                        Button {
                            print("Button Clicked")
                        } label: {
                            Text("팔로우")
                        }
                    }
                    .padding(.horizontal)
                    
                    Rectangle()
                        .fill(.gray.opacity(0.3))
                        .frame(height: 250)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Text("치킨 스테이크")
                                .font(.title2.bold())
                            
                            Spacer()
                            
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                        }
                        
                        HStack {
                            Image(systemName: "square")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                                .foregroundStyle(.gray)
                            
                            Text("30min")
                                .font(.caption)
                            
                            Image(systemName: "heart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                                .foregroundStyle(.gray)
                            
                            Text("20")
                                .font(.caption)
                        }
                        
                        Text("오늘 냉장고 재료로 만든 요리. 치킨과 바질의 어마어마한 조합이 만들어진다.")
                            .font(.subheadline)
                    }
                    .padding()
                    
                    Section {
                        TabView(selection: $activeTab) {
                            ForEach(RecipeTabCase.allCases, id: \.self) { tabCase in
                                tabCase.tabCaseContainerView()
                                    .tag(tabCase)
                                
                            }
                        }
                        .frame(height: 1700)
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .ignoresSafeArea(.container, edges: .bottom)
                        //                    .onChange(of: activeTab) { newActiveTab in
                        //                        let tabWidth = UIScreen.main.bounds.width / CGFloat(RecipeTabCase.allCases.count)
                        //                        let indicatorOffset = tabWidth * CGFloat(newActiveTab.index)
                        //                        contentOffset = indicatorOffset
                        //                        print(contentOffset)
                        //                    }
                    } header: {
                        TabIndicatorView(activeTab: $activeTab)
                    }
                }
            }
            .toolbar(.hidden, for: .tabBar)
            
            HStack(spacing: 24) {
                Button {
                    
                } label: {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .padding(12)
                        .foregroundStyle(.red)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.white)
//                                .border(.gray, width: 1)
//                                .stroke(.gray, lineWidth: 1)
                                .shadow(color: .gray, radius: 7)
                        }
                }
                
                Button {
                    
                } label: {
                    Text("내 보관함에 담기")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill()
                                .shadow(color: .black, radius: 7)
                        }
                }
            }
            .padding(.horizontal, 24)
            
            
        }
        
        
    }
    
    
}

#Preview {
    NavigationStack {
        RecipeView()
    }
}
