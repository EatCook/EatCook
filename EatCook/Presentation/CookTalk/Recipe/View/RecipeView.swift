//
//  RecipeView.swift
//  EatCook
//
//  Created by 이명진 on 2/8/24.
//

import SwiftUI

enum RecipeTabCase: String, CaseIterable {
    case recipe
    case ingredients
    
    var title: String {
        switch self {
        case .recipe: return "조리 과정"
        case .ingredients: return "요리 재료"
        }
    }
    
    var index: Int {
        return RecipeTabCase.allCases.firstIndex(of: self) ?? 0
    }
    
    var count: Int {
        return RecipeTabCase.allCases.count
    }
    
    var tabID: String {
        return self.rawValue + self.rawValue.prefix(4)
    }
    
    //    @ViewBuilder
    //    func tabCaseContainerView() -> some View {
    //        switch self {
    //        case .recipe: RecipeContainerView()
    //        case .ingredients: IngredientsContainerView()
    //        }
    //    }
}
enum RecipeType: String, CaseIterable {
    case recipe = "조리 과정"
    case ingredients = "요리 재료"
    
    var tabId: String {
        return self.rawValue + self.rawValue.prefix(4)
    }
}

struct RecipeMock: Identifiable, Hashable {
    var id: UUID = UUID()
    var type: RecipeType
    var description: String
    var ingredients: String
}

extension [RecipeMock] {
    var type: RecipeType {
        if let firstProduct = self.first {
            return firstProduct.type
        }
        
        return .recipe
    }
}

var recipe: [RecipeMock] = [
    RecipeMock(type: .recipe, description: "설탕 3큰술, 식초 5큰술, 가는소금 1작은술 넣어 잘 녹여주세요. 그리고 밥에 부어 섞은 후 밥을 충분히 식혀주세요", ingredients: ""),
    RecipeMock(type: .recipe, description: "양파 1/2개를 채썰어 물에 10분 담가 매운기를 조금 빼주세요.", ingredients: ""),
    RecipeMock(type: .recipe, description: "채반에 밭쳐 물기를 최대한 꼼꼼히 털어내주세요", ingredients: ""),
    RecipeMock(type: .recipe, description: "밥을 한입 크기로 잘 뭉친 후 와사비 적당량을 올려주세요", ingredients: ""),
    RecipeMock(type: .recipe, description: "양파 1/2개를 채썰어 물에 10분 담가 매운기를 조금 빼주세요.", ingredients: ""),
    RecipeMock(type: .recipe, description: "설탕 3큰술, 식초 5큰술, 가는소금 1작은술 넣어 잘 녹여주세요. 그리고 밥에 부어 섞은 후 밥을 충분히 식혀주세요", ingredients: ""),
    RecipeMock(type: .ingredients, description: "", ingredients: "파프리카"),
    RecipeMock(type: .ingredients, description: "", ingredients: "진간장"),
    RecipeMock(type: .ingredients, description: "", ingredients: "삼겹살 2인분"),
    RecipeMock(type: .ingredients, description: "", ingredients: "커피"),
    RecipeMock(type: .ingredients, description: "", ingredients: "통양파"),
    RecipeMock(type: .ingredients, description: "", ingredients: "마늘"),
    RecipeMock(type: .ingredients, description: "", ingredients: "청양고추"),
]


struct RecipeView: View {
    @State private var activeTab: RecipeType = .recipe
    @State private var sampleData: [[RecipeMock]] = []
    @State private var animationProgress: CGFloat = 0
    @Namespace private var animation
    //    @State private var contentOffset: CGFloat = 0
    
    var body: some View {
        ScrollViewReader { proxy in
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
                            ForEach(sampleData, id: \.self) { data in
                                recipeSectionView(data)
                            }
                        } header: {
                            tapIndicatorView(proxy)
                        }
                    }
                }
                
                //                .toolbar(.hidden, for: .tabBar)
                
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
            .coordinateSpace(name: "CONTENTVIEW")
            .onAppear {
                guard sampleData.isEmpty else { return }
                
                for type in RecipeType.allCases {
                    let data = recipe.filter { $0.type == type }
                    sampleData.append(data)
                }
            }
        }
        
        
    }
    
    @ViewBuilder
    func tapIndicatorView(_ proxy: ScrollViewProxy) -> some View {
        HStack {
            ForEach(RecipeType.allCases, id: \.self) { tabCase in
                Text(tabCase.rawValue)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.gray8)
                    .padding(.vertical, 12)
                    .background(alignment: .bottom) {
                        if activeTab == tabCase {
                            RoundedRectangle(cornerRadius: 8)
                                .fill()
                                .frame(height: 3)
                                .padding(.horizontal, -10)
                            //                                .offset(y: 15)
                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                        }
                    }
                    .padding(.horizontal, 25)
                    .contentShape(Rectangle())
                    .id(tabCase.tabId)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            activeTab = tabCase
                            animationProgress = 1.0
                            proxy.scrollTo(tabCase, anchor: .topLeading)
                        }
                    }
                
            }
        }
        .onChange(of: activeTab) { newValue in
            withAnimation(.easeInOut(duration: 0.3)) {
                proxy.scrollTo(newValue.tabId, anchor: .center)
            }
        }
        .checkAnimationEnd(for: animationProgress) {
            animationProgress = 0.0
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .background(alignment: .bottom) {
            Rectangle()
                .fill(.gray2)
                .frame(height: 1)
        }
        
    }
    
    @ViewBuilder
    func recipeSectionView(_ data: [RecipeMock]) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            if let firstType = data.first {
                Text(firstType.type.rawValue)
                    .font(.title)
                    .fontWeight(.semibold)
            }
            
            ForEach(data) { data in
                recipeRowView(data)
                //                if data.type == .recipe {
                //                    recipeRowView(data)
                //                } else {
                //
                //                }
            }
        }
        .padding(15)
        .id(data.type)
        .offset("CONTENTVIEW") { rect in
            let minY = rect.minY
            if (minY < 30 && -minY < (rect.midY / 2) && activeTab != data.type) && animationProgress == 0 {
                withAnimation(.easeInOut(duration: 0.3)) {
                    activeTab = (minY < 30 && -minY < (rect.midY / 2) && activeTab != data.type) ? data.type : activeTab
                }
            }
        }
    }
    
    @ViewBuilder
    func recipeRowView(_ data: RecipeMock) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                Text("Step 1")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.primary6)
                
                Text(data.description)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(.gray8)
            }
            
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray3)
                .frame(height: 230)
        }
    }
    
}

#Preview {
    RecipeView()
}
