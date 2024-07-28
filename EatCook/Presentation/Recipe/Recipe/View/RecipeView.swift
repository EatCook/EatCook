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
                    requestManager: NetworkManager()))),
        loginUserInfo: LoginUserInfoManager.shared)
    
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
                                naviPathFinder.addPath(.otherUserProfile(viewModel.userId))
                            }
                            
                            Spacer()
                            
                            if !viewModel.isMyRecipe {
                                FollowButton(isFollowed: $viewModel.isFollowed) {
                                    viewModel.isFollowed.toggle()
                                }
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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .imageScale(.large)
                            .foregroundStyle(.black)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    if viewModel.isMyRecipe {
                        Menu {
                            Button {
                                naviPathFinder.addPath(.recipeCreate(""))
                            } label: {
                                Label("편집", systemImage: "pencil")
                            }
                            
                            Button("삭제", systemImage: "trash", role: .destructive) {
                                Task {
                                    await viewModel.requestDeleteRecipe(viewModel.postId)
                                    
                                    if !viewModel.isDeletedLoading && viewModel.isDeletedError == nil {
                                        naviPathFinder.pop()
                                    }
                                }
                            }
                        } label: {
                            Image("ellipsis")
                                .imageScale(.large)
                                .foregroundStyle(.black)
                        }
                    } else {
                        Button {
                            viewModel.requestLikedAddOrDelete(viewModel.postId)
                        } label: {
                            Image(systemName: viewModel.isLiked ? "heart.fill" : "heart")
                                .imageScale(.large)
                                .foregroundStyle(viewModel.isLiked ? .red : .black)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.responseRecipeRead(postId)
            }
            
            Button {
                viewModel.requestArchiveAddOrDelete(viewModel.postId)
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
