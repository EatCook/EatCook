//
//  SearchView.swift
//  EatCook
//
//  Created by 이명진 on 2/8/24.
//

import SwiftUI


struct SearchView: View {
    @StateObject private var searchViewModel = SearchViewModel()
    
    @State private var isSearching = false
    @State var recentSearchData: [[String]] = [["홍고추"], ["계란덮밥", "덮밥"], ["감바스", "마늘", "고추"], ["감바스", "마늘", "고추", "양배추"], ["감바스", "마늘", "고추", "양배추", "닭갈비"]]
    
    @State private var navigationPath = NavigationPath()
    @SwiftUI.Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var naviPathFinder: NavigationPathFinder

    var body: some View {
    
            VStack {
                VStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(.backButton).resizable()
                                .frame(width: 20, height: 20)
                        }.padding(.trailing)
                        
                        TextField("재료 또는 레시피를 검색해 보세요", text: $searchViewModel.searchText, onCommit: {
                            guard searchViewModel.searchText.count > 0 else {
                                // TODO : Alert 창
                                return
                            }
                            searchViewModel.searchCheckValidate()
                        })
                        
                        Button(action: {
                            searchViewModel.searchCheckValidate()
                        }) {
                            Image(systemName: "magnifyingglass")
                                .tint(.gray)
                        }
                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(searchViewModel.tags, id: \.self) { tag in
                                SearchTagView(tag: tag.value) {
                                    searchViewModel.removeTag(tag: tag.value)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }.padding(.top)
                        .padding(.bottom , 12)
                }
                .background(Color.gray10)
                .padding(.bottom)
                
                
                if !searchViewModel.isSearching {
                    ScrollView {
                        VStack {
                            ZStack(alignment: .top) {
                                VStack {
                                    HStack(alignment: .bottom) {
                                        Text("지금 많이 검색하고 있어요")
                                            .font(.title3).bold()
                                        Text(searchViewModel.getCurrentDateString())
                                            .foregroundColor(.gray5)
                                            .font(.system(size: 12))
                                        Spacer()
                                    }
                                    .padding(.vertical, 20)
                                    .padding(.horizontal, 16)
                                    
                                    LazyVStack(alignment: .leading) {
                                        ForEach(searchViewModel.topRankData) { data in
                                            Button(action: {
                                                print("index ::", data)
                                            }) {
                                                HStack {
                                                    if data.rank > 3 {
                                                        HStack(spacing: 24) {
                                                            Text("\(data.rank)").frame(width : 20 , height : 20).foregroundColor(.secondary).bold()
                                                            Text(data.searchWord).font(.system(size: 18))
                                                        }
                                                        .padding(.vertical, 12)
                                                    } else {
                                                        HStack(spacing: 24) {
                                                            Text("\(data.rank)").frame(width : 20 , height : 20).foregroundColor(.primary6).bold()
                                                            Text(data.searchWord).font(.system(size: 18)).bold()
                                                        }
                                                        .padding(.vertical, 12)
                                                    }
                                                    Spacer()
                                                    
                                                    if data.rankChange == 0 {
                                                        Image(.same).resizable().scaledToFit().frame(width: 15, height: 15)
                                                    } else {
                                                        Image(data.rankChange > 0 ? .upPrimary : .downGray).resizable().scaledToFit().frame(width: 15, height: 15)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                    Spacer()
                                }
                                .padding(.bottom, 30)
                                .background(Color.white)
                                
                                if isSearching {
                                    VStack(alignment: .leading, spacing: 0) {
                                        RecentSearchView(recentSearchData: $recentSearchData)
                                        Rectangle().fill(Color.black.opacity(0.6))
                                            .onTapGesture {
                                                withAnimation {
                                                    isSearching = false
                                                }
                                            }
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                }
                            }
                        }
                        
                    }
                    
            
                    .padding(.top, 15)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarHidden(true)
                    .background(Color.white)
                } else {
                    VStack {
                        SearchViewCustomTabView(selectedTab: $searchViewModel.selectedTab)
                        TabView(selection: $searchViewModel.selectedTab) {
                            IngredientsView(ingredients: $searchViewModel.ingredients)
                                .tag(selectedTabType.ingredient)
                            RecipesView(recipes: $searchViewModel.recipes)
                                .tag(selectedTabType.recipe)
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    }
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarHidden(true)
                    .background(Color.white)
                }
            }
            .environmentObject(searchViewModel)
            .navigationBarTitle("", displayMode: .inline)
        
        }
       
    
}




struct SearchViewCustomTabView: View {
    @EnvironmentObject var searchViewModel: SearchViewModel
    @Binding var selectedTab: selectedTabType
   
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    withAnimation {
                        selectedTab = .ingredient
                    }
                   
                }) {
                    VStack {
                        Text("재료")
                            .bold()
                            .foregroundColor(selectedTab == .ingredient ? .primary6 : .gray5)
                        
                        if selectedTab == .ingredient {
                            Rectangle()
                                .fill(Color.orange)
                                .frame(height: 3)
                                .transition(.opacity)
                        } else {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(height: 3)
                        }
                    }
                }
                Spacer()
                Button(action: {
                    withAnimation {
                        selectedTab = .recipe
                    }
                }) {
                    VStack {
                        Text("레시피")
                            .bold()
                            .foregroundColor(selectedTab == .recipe ? .primary6 : .gray5)
                            .padding(.bottom, 8)
                        
                        if selectedTab == .recipe {
                            Rectangle()
                                .fill(Color.orange)
                                .frame(height: 3)
                                .transition(.opacity)
                        } else {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(height: 3)
                        }
                    }
                }
            }
            .padding()
            .background(Color.white)

        }
    }
}


struct IngredientsView: View {
    @EnvironmentObject var searchViewModel: SearchViewModel
    @Binding var ingredients : [Ingredient]
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        if ingredients.isEmpty {
            VStack {
                HStack {
                    HStack {
                        ForEach(searchViewModel.tags.indices, id: \.self) { index in
                            let tag = searchViewModel.tags[index]
                            Text("'\(tag.value) '\(index < searchViewModel.tags.count - 1 ? "," : "")")
                                .font(.headline)
                              
                        }
                    }
                    
                    Text(" 검색 결과가 없습니다.")
                        .font(.headline)
                }
                
                
                Text("추천 레시피를 둘러볼까요?")
                    .foregroundColor(.gray6)
                    .padding(.bottom)
                Button(action: {
                    // Navigate to home
                }) {
                    Text("홈으로 가기")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.primary7)
                        .cornerRadius(8)
                }
            }
            .padding()
            
        }else{
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(ingredients) { ingredient in
                        IngredientView(ingredient: ingredient)
                    }
                }
                .padding()
                
            }
            
        }
        
        
        

    }
}

struct IngredientView: View {
    let ingredient: Ingredient
    @StateObject private var loader = ImageLoader()

    var body: some View {
        VStack(alignment : .center) {
            ZStack(alignment: .topLeading) {
                ZStack(alignment : .topLeading) {
                    if let imageUrl = URL(string: "\(Environment.AwsBaseURL)/\(ingredient.imageFilePath)") {
                        ZStack(alignment: .bottomTrailing) {
                            AsyncImage(url: imageUrl) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(height: 100) // 원하는 높이 설정
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(height: 100) // 원하는 높이 설정
                                        .clipped()
                                        .cornerRadius(10)
                                case .failure:
                                    ZStack(alignment: .center) {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(.gray2)
                                            .frame(maxWidth: .infinity, minHeight : 100)
                                        VStack(spacing: 8) {
                                            Image(systemName: "photo")
                                                .resizable()
                                                .frame(width: 25, height: 20)
                                                .foregroundStyle(.gray5)
                                            
                                            Text("이미지 다운로드에 실패했어요.")
                                                .font(.system(size: 10, weight: .regular))
                                                .foregroundStyle(.gray6)
                                        }
                                    }
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                    }
                }

                HStack {
                    Image(.whiteHeart)
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text(String(ingredient.likeCount))
                        .font(.callout)
                        .foregroundColor(.white)
                }
                .padding(.vertical, 3)
                .padding(.horizontal, 5)
                .background(Color.black.opacity(0.2))
                .cornerRadius(5)
                .padding([.top, .leading], 5) // 적절한 위치를 위해 패딩 추가
            }
           
            VStack {
                VStack(alignment : .leading) {
                    VStack(alignment : .leading) {
                        Text(ingredient.recipeName) .font(.system(size: 15))
                            .lineLimit(1)
                            .font(.title3).bold()
                        Text(ingredient.introduction)
                            .font(.system(size: 15))
                            .padding(.top, 2)
                            .lineLimit(2) // Limit to 2 lines
                            .truncationMode(.tail) // Add truncation mode to indicate overflow
                    }.frame(maxWidth: .infinity, alignment: .leading) // 항상 왼쪽 정렬

                }
                Spacer()
                VStack(alignment: .leading) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(ingredient.foodIngredients.indices, id: \.self) { index in
                                VStack {
                                    Text(ingredient.foodIngredients[index])
                                        .font(.system(size: 8))
                                        .padding(.horizontal, 4)
                                        .padding(.vertical, 2)
                                        .foregroundColor(Color.gray.opacity(0.6))
                                }
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                            }
                        }
                    }
                }
            }
           

               
        }
//        .frame(height : 220)
        .background(Color.white)
        .cornerRadius(10)
        
    }
}


struct RecipesView: View {
    @EnvironmentObject var searchViewModel: SearchViewModel
    @Binding var recipes: [Recipe]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        if recipes.isEmpty {
            VStack {
                HStack {
                    HStack {
                        ForEach(searchViewModel.tags.indices, id: \.self) { index in
                            let tag = searchViewModel.tags[index]
                            Text("'\(tag.value) '\(index < searchViewModel.tags.count - 1 ? "," : "")")
                                .font(.headline)
                              
                        }
                    }
                    
                    Text(" 검색 결과가 없습니다.")
                        .font(.headline)
                }
                
                
                Text("추천 레시피를 둘러볼까요?")
                    .foregroundColor(.gray6)
                    .padding(.bottom)
                Button(action: {
                    // Navigate to home
                }) {
                    Text("홈으로 가기")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.primary7)
                        .cornerRadius(8)
                }
            }
            .padding()
            
            
            
            
        }else{
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(recipes) { recipe in
                        SearchRecipeView(recipe: recipe)
                    }
                }
                .padding()
                
            }
            
        }
        

        
    }
}

struct SearchRecipeView: View {
    let recipe: Recipe
    @StateObject private var loader = ImageLoader()

    var body: some View {
        VStack {
            
            ZStack(alignment: .topLeading) {
                ZStack(alignment : .topLeading) {
                    if let imageUrl = URL(string: "\(Environment.AwsBaseURL)/\(recipe.imageFilePath)") {
                        ZStack(alignment: .bottomTrailing) {
                            AsyncImage(url: imageUrl) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(height: 100) // 원하는 높이 설정
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(height: 100) // 원하는 높이 설정
                                        .clipped()
                                        .cornerRadius(10)
                                case .failure:
                                    ZStack(alignment: .center) {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(.gray2)
                                            .frame(maxWidth: .infinity, minHeight : 100)
                                        VStack(spacing: 8) {
                                            Image(systemName: "photo")
                                                .resizable()
                                                .frame(width: 25, height: 20)
                                                .foregroundStyle(.gray5)
                                            
                                            Text("이미지 다운로드에 실패했어요.")
                                                .font(.system(size: 10, weight: .regular))
                                                .foregroundStyle(.gray6)
                                        }
                                    }
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                    }
                }

                HStack {
                    Image(.whiteHeart)
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text(String(recipe.likeCount))
                        .font(.callout)
                        .foregroundColor(.white)
                }
                .padding(.vertical, 3)
                .padding(.horizontal, 5)
                .background(Color.black.opacity(0.2))
                .cornerRadius(5)
                .padding([.top, .leading], 5) // 적절한 위치를 위해 패딩 추가
            }
  
            
            
            
            VStack {
                VStack(alignment : .leading) {
                    VStack(alignment : .leading) {
                        Text(recipe.recipeName) .font(.system(size: 15))
                            .lineLimit(1)
                            .font(.title3).bold()
                        Text(recipe.introduction)
                            .font(.system(size: 15))
                            .padding(.top, 2)
                            .lineLimit(2) // Limit to 2 lines
                            .truncationMode(.tail) // Add truncation mode to indicate overflow
                    }.frame(maxWidth: .infinity, alignment: .leading) // 항상 왼쪽 정렬

                }
                Spacer()
                VStack(alignment: .leading) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(recipe.foodIngredients.indices, id: \.self) { index in
                                VStack {
                                    Text(recipe.foodIngredients[index])
                                        .font(.system(size: 8))
                                        .padding(.horizontal, 4)
                                        .padding(.vertical, 2)
                                        .foregroundColor(Color.gray.opacity(0.6))
                                }
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                            }
                        }
                    }
                }
                
            }
            
            
           
        }
//        .frame(height : 220)
        .background(Color.white)
        .cornerRadius(10)
        
    }
}



struct SearchTagView: View {
    let tag: String
    let onDelete: () -> Void

    var body: some View {
        HStack {
            Text(tag)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
            
            Button(action: onDelete) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.gray3)
        .cornerRadius(5)
    }
}

struct RecentSearchView: View {
    @State var searchText = ""
    @Binding var recentSearchData: [[String]]

    var body: some View {
        VStack {
            HStack {
                Text("최근 검색어")
                    .font(.title3)
                    .bold()
                
                Spacer()
                
                Button(action: {
                    recentSearchData = []
                }) {
                    Text("전체 삭제")
                        .font(.body)
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            
            LazyVStack(alignment: .leading) {
                if recentSearchData.isEmpty {
                    HStack {
                        Text("최근 검색어가 없습니다")
                            .font(.system(size: 16))
                            .font(.callout)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 24)
                } else {
                    ForEach(recentSearchData, id: \.self) { title in
                        HStack {
                            Image(.search)
                                .resizable()
                                .frame(width: 20, height: 20)
                            
                            Button(action: {
                                print(title)
                            }) {
                                Text(title.joined(separator: ", "))
                                    .font(.system(size: 16))
                                    .font(.callout)
                            }
                            .frame(height: 38)
                            .padding(.horizontal, 12)
                            
                            Spacer()
                            
                            Button(action: {}) {
                                Image(.cancel)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 12)
        }
        .background(Color.white)
    }
}

//테스트 데이터
extension SearchView {
    static let testDataKeyword = ["홍고추", "계란덮밥", "칼국수", "떡볶이"]
    static let testDataRank = [
        "된짱찌개",
        "김치볶음밥",
        "우유",
        "삼겹살 김치 볶음",
        "우육탕면",
        "케이크",
        "떡국",
        "생크림",
        "수육",
        "목살구이"
    ]
}

#Preview {
    SearchView().environmentObject(NavigationPathFinder.shared)
}
