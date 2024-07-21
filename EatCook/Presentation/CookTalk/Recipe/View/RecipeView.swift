//
//  RecipeView.swift
//  EatCook
//
//  Created by 이명진 on 2/8/24.
//

import SwiftUI

enum RecipeType: String, CaseIterable, Identifiable {
    case recipe = "조리 과정"
    case ingredients = "요리 재료"
    
    var id: String { rawValue }
    var tabId: String { rawValue + "Tab" }
}

struct RecipeData: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var type: RecipeType
    var image: String = ""
    var step: Int?
    var description: String
}

extension Array where Element == RecipeData {
    var type: RecipeType {
        if let firstProduct = self.first {
            return firstProduct.type
        }
        return .recipe
    }
}

struct RecipeView: View {
    @State private var activeTab: RecipeType = .recipe
    @Namespace private var animation
    @State private var sectionOffsets: [RecipeType: CGFloat] = [:]
    @State private var contentOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    
    @EnvironmentObject private var naviPathFinder: NavigationPathFinder
    
    var postId: Int
    var userId: String = "itcook"
    
    @StateObject private var viewModel = RecipeViewModel(
        recipeUseCase: RecipeUseCase(
            eatCookRepository: EatCookRepository(
                networkProvider: NetworkProviderImpl(
                    requestManager: NetworkManager()))))
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                if viewModel.isLoading {
                    
                } else if let error = viewModel.error {
                    Text(error)
                } else if let data = viewModel.recipeReadData {
                    LazyVStack {
                        HStack(spacing: 6) {
                            HStack {
                                Circle()
                                    .fill(.gray3)
                                    .frame(width: 25, height: 25)
                                
                                Text(data.nickName)
                                    .font(.system(size: 16, weight: .semibold))
                            }
                            .onTapGesture {
                                naviPathFinder.addPath(.otherUserProfile)
                            }
                            
                            Spacer()
                            
                            FollowButton(isFollowed: $viewModel.isFollowed) {
                                viewModel.isFollowed.toggle()
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 20)
                        
                        if let imageUrl = URL(string: "\(Environment.AwsBaseURL)/\(data.postImagePath)") {
                            AsyncImage(url: imageUrl) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(4/3, contentMode: .fit)
//                                        .scaledToFit()
                                case .failure:
                                    LoadFailImageView()
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text(data.recipeName)
                                    .font(.system(size: 24, weight: .semibold))
                                
                                Spacer()
                            }
                            .padding(.top, 32)
                            
                            HStack(spacing: 6) {
                                Image(systemName: "clock")
                                    .resizable()
                                    .frame(width: 13, height: 14)
                                    .scaledToFit()
                                    .foregroundStyle(.gray5)
                                
                                Text("\(data.recipeTime)")
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundStyle(.gray5)
                                    .padding(.trailing, 8)
                                
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .frame(width: 14, height: 13)
                                    .scaledToFit()
                                    .foregroundStyle(.gray5)
                                
                                Text("\(data.followerCount)")
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundStyle(.gray5)
                            }
                            
                            Text(data.introduction)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundStyle(.gray8)
                        }
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .offset(y: -20)
                        
                        Rectangle()
                            .fill(.gray1)
                            .frame(height: 16)
                        
                        VStack {
                            HStack {
                                Text("요리 재료")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundStyle(.gray8)
                                    .padding(.top, 24)
                                
                                Spacer()
                            }
                            
                            ChipLayout(verticalSpacing: 5, horizontalSpacing: 10) {
                                ForEach(viewModel.recipeProcessData, id: \.id) { item in
                                    if item.type == .ingredients {
                                        Text(item.description)
                                            .padding(6)
                                            .font(.system(size: 16))
                                            .foregroundStyle(.gray6)
                                            .background {
                                                RoundedRectangle(cornerRadius: 6)
                                                    .foregroundStyle(.gray3)
                                            }
                                    }
                                }
                            }
                        }
                        .frame(maxHeight: .infinity)
                        .padding(.horizontal, 16)
                        
                        VStack {
                            Rectangle()
                                .fill(.gray1)
                                .frame(height: 16)
                            
                            HStack {
                                Text("조리 과정")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundStyle(.gray8)
                                    .padding(.top, 24)
                                
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                        }
                        .padding(.top, 24)
                        
                        VStack {
                            ForEach(viewModel.recipeProcessData, id: \.id) { item in
                                if item.type == .recipe {
                                    recipeRowView(item)
                                        .padding(.vertical, 8)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 100)
                    }
                }
            }
            .onAppear {
                viewModel.responseRecipeRead(postId)
            }
            
            Button {
                viewModel.requestArchiveAdd(viewModel.postId)
//                viewModel.isArchived.toggle()
            } label: {
                Text(viewModel.isArchived ? "이미 담겨있어요" : "내 보관함에 담기")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(viewModel.isArchived ? .gray5 : .white)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(viewModel.isArchived ? .gray3 : .primary7)
                            .padding(.horizontal, 16)
                            
                    }
            }
        }
        
        
//            ScrollViewReader { proxy in
//                ZStack(alignment: .bottom) {
//                    ScrollView {
//                        if viewModel.isLoading {
//                            ProgressView()
//                        } else if let error = viewModel.error {
//                            Text(error)
//                        } else if let recipeData = viewModel.recipeReadData {
//                            LazyVStack(spacing: 12, pinnedViews: [.sectionHeaders]) {
//                                HStack {
//                                    Circle()
//                                        .fill(.gray)
//                                        .frame(width: 25, height: 25)
//                                    
//                                    Text(recipeData.nickName)
//                                        .font(.subheadline)
//                                        .fontWeight(.semibold)
//                                    
//                                    Text("12.2k")
//                                        .font(.subheadline)
//                                        .foregroundStyle(.orange)
//                                    
//                                    Spacer()
//                                    
//                                    Button {
//                                        
//                                    } label: {
//                                        Text("팔로우")
//                                    }
//                                }
//                                .padding(.horizontal)
//                                
//                                if let imageUrl = URL(string: "\(Environment.AwsBaseURL)/\(recipeData.postImagePath)") {
//                                    AsyncImage(url: imageUrl) { phase in
//                                        switch phase {
//                                        case .empty:
//                                            ProgressView()
//                                        case .success(let image):
//                                            image
//                                                .resizable()
//                                                .frame(height: 250)
//                                                .scaledToFit()
//                                        case .failure:
//                                            Image(systemName: "photo")
//                                                .resizable()
//                                                .frame(height: 250)
//                                                .aspectRatio(contentMode: .fit)
//                                        @unknown default:
//                                            EmptyView()
//                                        }
//                                    }
//                                }
//                                
//                                VStack(alignment: .leading, spacing: 20) {
//                                    HStack {
//                                        Text(recipeData.recipeName)
//                                            .font(.title2.bold())
//                                        
//                                        Spacer()
//                                        
//                                        Image(systemName: "square.and.arrow.up")
//                                            .resizable()
//                                            .scaledToFit()
//                                            .frame(width: 20)
//                                    }
//                                    
//                                    HStack {
//                                        Image(systemName: "square")
//                                            .resizable()
//                                            .scaledToFit()
//                                            .frame(width: 20)
//                                            .foregroundStyle(.gray)
//                                        
//                                        Text("30min")
//                                            .font(.caption)
//                                        
//                                        Image(systemName: "heart")
//                                            .resizable()
//                                            .scaledToFit()
//                                            .frame(width: 20)
//                                            .foregroundStyle(.gray)
//                                        
//                                        Text("20")
//                                            .font(.caption)
//                                    }
//                                    
//                                    Text(recipeData.introduction)
//                                        .font(.subheadline)
//                                }
//                                .padding()
//                                
//                                Section {
//                                    ForEach(viewModel.recipeProcessData, id: \.self) { data in
//                                        recipeSectionView(data)
//                                    }
//                                } header: {
//                                    tapIndicatorView(proxy)
//                                }
//                            }
////                            .padding(.bottom, 80)
//                        }
//                    }
////                    .padding(.bottom, 80)
//                    .coordinateSpace(name: "CONTENTVIEW")
//                    .onAppear {
//                        viewModel.responseRecipeRead(postId)
//                    }
//                    .background(
//                        GeometryReader { proxy in
//                            Color.clear
//                                .preference(key: ViewOffsetKey.self, value: proxy.frame(in: .named("CONTENTVIEW")).minY)
//                        }
//                    )
//                    .onPreferenceChange(ViewOffsetKey.self) { value in
//                        contentOffset = value
//                        if !isAnimating {
//                            updateActiveTab()
//                        }
//                    }
//                    
//                    /// 하단 버튼
//                    HStack(spacing: 24) {
//                        Button {
//                            
//                        } label: {
//                            Image(systemName: "heart.fill")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 30)
//                                .padding(12)
//                                .foregroundStyle(.red)
//                                .background {
//                                    RoundedRectangle(cornerRadius: 8)
//                                        .fill(.white)
//                                        .shadow(color: .gray, radius: 7)
//                                }
//                        }
//                        
//                        Button {
//                            
//                        } label: {
//                            Text("내 보관함에 담기")
//                                .font(.headline)
//                                .fontWeight(.semibold)
//                                .foregroundStyle(.white)
//                                .frame(maxWidth: .infinity)
//                                .padding()
//                                .background {
//                                    RoundedRectangle(cornerRadius: 8)
//                                        .fill()
//                                        .shadow(color: .black, radius: 7)
//                                }
//                        }
//                    }
////                    .background(.clear)
//                    .padding(.horizontal, 24)
//                }
//                .onChange(of: activeTab) { newValue in
//                    if !isAnimating {
//                        isAnimating = true
//                        withAnimation(.easeInOut(duration: 0.3)) {
//                            proxy.scrollTo(newValue.tabId, anchor: .top)
//                        }
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
//                            isAnimating = false
//                        }
//                    }
//                }
//            }
        
    }
    
    @ViewBuilder
    func recipeRowView(_ data: RecipeData) -> some View {
        if data.type == .recipe {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top) {
                    if let step = data.step {
                        Text("Step \(step)")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.orange)
                    }
                    
                    Text(data.description)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(.gray)
                }
                
                if let imageUrl = URL(string: "\(Environment.AwsBaseURL)/\(data.image)") {
                    AsyncImage(url: imageUrl) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .frame(maxWidth: .infinity)
                                .aspectRatio(4/3, contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        case .failure:
                            LoadFailImageView()
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
            }
        }
    }
//    @ViewBuilder
//    func tapIndicatorView(_ proxy: ScrollViewProxy) -> some View {
//        HStack {
//            ForEach(RecipeType.allCases, id: \.self) { tabCase in
//                Text(tabCase.rawValue)
//                    .font(.system(size: 16, weight: .semibold))
//                    .foregroundStyle(activeTab == tabCase ? .black : .gray)
//                    .padding(.vertical, 12)
//                    .background(alignment: .bottom) {
//                        if activeTab == tabCase {
//                            RoundedRectangle(cornerRadius: 8)
//                                .fill()
//                                .frame(height: 3)
//                                .padding(.horizontal, -10)
//                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
//                        }
//                    }
//                    .padding(.horizontal, 25)
//                    .contentShape(Rectangle())
//                    .id(tabCase.tabId)
//                    .onTapGesture {
//                        isAnimating = true
//                        withAnimation(.easeInOut(duration: 0.3)) {
//                            activeTab = tabCase
//                            proxy.scrollTo(tabCase.tabId, anchor: .top)
//                        }
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
//                            isAnimating = false
//                        }
//                    }
//            }
//        }
//        .frame(maxWidth: .infinity)
//        .background(.white)
//    }
//    
//    @ViewBuilder
//    func recipeSectionView(_ data: [RecipeData]) -> some View {
//        VStack(alignment: .leading, spacing: 15) {
//            if let firstType = data.first {
//                Text(firstType.type.rawValue)
//                    .font(.title)
//                    .fontWeight(.semibold)
//            }
//            
//            if data.type == .recipe {
//                ForEach(data) { data in
//                    recipeRowView(data)
//                }
//            } else {
//                ChipLayout(verticalSpacing: 5, horizontalSpacing: 10) {
//                    ForEach(data, id: \.id) { item in
//                        Text(item.description)
//                            .padding(6)
//                            .font(.system(size: 16))
//                            .foregroundStyle(.gray6)
//                            .background {
//                                RoundedRectangle(cornerRadius: 6)
//                                    .foregroundStyle(.gray3)
//                            }
//                        
//                    }
//                }
//                .padding(.bottom, 80)
//            }
//        }
//        .padding(15)
//        .id(data.type.tabId)
//        .background(
//            GeometryReader { geo -> Color in
//                DispatchQueue.main.async {
//                    sectionOffsets[data.type] = geo.frame(in: .named("CONTENTVIEW")).minY
//                }
//                return Color.clear
//            }
//        )
//    }
//    
//    @ViewBuilder
//    func recipeRowView(_ data: RecipeData) -> some View {
//        if data.type == .recipe {
//            VStack(alignment: .leading, spacing: 16) {
//                HStack(alignment: .top) {
//                    if let step = data.step {
//                        Text("Step \(step)")
//                            .font(.system(size: 16, weight: .semibold))
//                            .foregroundStyle(.orange)
//                    }
//                    
//                    Text(data.description)
//                        .font(.system(size: 16, weight: .regular))
//                        .foregroundStyle(.gray)
//                }
//                
//                if let imageUrl = URL(string: "\(Environment.AwsBaseURL)/\(data.image)") {
//                    AsyncImage(url: imageUrl) { phase in
//                        switch phase {
//                        case .empty:
//                            ProgressView()
//                        case .success(let image):
//                            image
//                                .resizable()
//                                .frame(height: 220)
//                                .scaledToFit()
//                        case .failure:
//                            Image(systemName: "photo")
//                                .resizable()
//                                .frame(height: 220)
//                                .aspectRatio(contentMode: .fit)
//                        @unknown default:
//                            EmptyView()
//                        }
//                    }
//                }
//            }
//        }
//    }
//    
//    private func updateActiveTab() {
//        guard !sectionOffsets.isEmpty else { return }
//        let sortedOffsets = sectionOffsets.sorted { abs($0.value - contentOffset) < abs($1.value - contentOffset) }
//        if let first = sortedOffsets.first {
//            if activeTab != first.key {
//                withAnimation(.easeInOut(duration: 0.3)) {
//                    activeTab = first.key
//                }
//            }
//        }
//    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    RecipeView(postId: 10)
        .environmentObject(NavigationPathFinder.shared)
}
