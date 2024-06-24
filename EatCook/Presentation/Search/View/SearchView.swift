//
//  SearchView.swift
//  EatCook
//
//  Created by 이명진 on 2/8/24.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    @State private var isSearching = false
    @FocusState private var isFocused: Bool
    @State var topRankData: [String] = []
    @State private var tags: [Tag] = []
    @State var recentSearchData: [[String]] = [["홍고추"],["계란덮밥", "덮밥"], ["감바스","마늘","고추"],["감바스","마늘","고추", "양배추"],["감바스","마늘","고추", "양배추", "닭갈비"]]
    @EnvironmentObject private var naviPathFinder: NavigationPathFinder
    @State private var navigationPath = NavigationPath()
    @SwiftUI.Environment(\.dismiss) private var dismiss
    @StateObject private var searchViewModel = SearchViewModel()
    @State var recipes = [Recipe]()
    @State var ingredients = [Recipe]()
    @State private var selectedTab = 0
    
    private func removeTag(tag: String) {
        tags.removeAll { $0.value == tag }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray10.edgesIgnoringSafeArea(.all)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Button {
                                dismiss()
                            } label: {
                                Image(.backButton).resizable().frame(width: 12, height: 20)
                            }.padding(.trailing)
                            
                            TextField("재료 또는 레시피를 검색해 보세요", text: $searchText, onCommit: {
                                tags.append(Tag(value: searchText))
                            })
                            
                            Button(action: {
//                                SearchService.shard.getSearchMenu(parameters: ["lastId" : "" , "recipeNames" : [] , "ingredients" : tags.map { String($0.value) } , "size" : "10"]) { result in
//                                    print("SearchView ::" , result.data)
//                                } failure: { failResult in
//                                    print("SearchView failResult :", failResult)
//                                }

                                
                                
                            }) {
                                Image(systemName: "magnifyingglass")
                                    .tint(.gray)
                            }
                        }
                        .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(tags, id: \.self) { tag in
                                    SearchTagView(tag: tag.value) {
                                        removeTag(tag: tag.value)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }.padding(.top)
                    }.background(Color.gray10)
                        .padding(.bottom)
                    
                    if !recipes.isEmpty {
                        VStack {
                            ZStack(alignment: .top) {
                                VStack {
                                    HStack(alignment: .bottom) {
                                        Text("지금 많이 검색하고 있어요")
                                            .font(.title3).bold()
                                        Text("2024.03.13")
                                            .foregroundColor(.gray5)
                                            .font(.system(size: 12))
                                        Spacer()
                                    }
                                    .padding(.vertical, 20)
                                    .padding(.horizontal, 16)
                                    
                                    LazyVStack(alignment: .trailing) {
                                        ForEach(SearchView.testDataRank.indices, id: \.self) { index in
                                            Button(action: {}) {
                                                HStack {
                                                    if index + 1 > 3 {
                                                        HStack(spacing: 24) {
                                                            Text("\(index + 1)").foregroundColor(.secondary).bold()
                                                            Text(SearchView.testDataRank[index]).font(.system(size: 18))
                                                        }
                                                        .padding(.vertical, 12)
                                                    } else {
                                                        HStack(spacing: 24) {
                                                            Text("\(index + 1)").foregroundColor(.primary6).bold()
                                                            Text(SearchView.testDataRank[index]).font(.system(size: 18)).bold()
                                                        }
                                                        .padding(.vertical, 12)
                                                    }
                                                    Spacer()
                                                    Image(.upPrimary)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 18)
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
                        .padding(.top, 15)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .navigationBarTitle("", displayMode: .inline)
                        .navigationBarHidden(true)
                        .background(Color.white)
                    }else{
                        VStack {
                            SearchViewCustomTabView(selectedTab: $selectedTab)
                            if selectedTab == 0 {
                                IngredientsView(ingredients: $ingredients)
                            } else {
                                RecipesView(recipes: $recipes)
                            }
                            Spacer()
                        }
                        
                    }
                    

                    
         
                }

            }
        }
    }
}

struct IngredientsView: View {
    @Binding var ingredients : [Recipe]
    var body: some View {
        NavigationView {
            List(ingredients) { recipe in
                IngredientView(ingredient:  recipe)
            }
            .navigationTitle("Ingredients")
        }
    }
}

struct SearchViewCustomTabView: View {
    @Binding var selectedTab: Int

    var body: some View {
        HStack {
            Button(action: {
                selectedTab = 0
            }) {
                Text("재료")
                    .foregroundColor(selectedTab == 0 ? .orange : .gray)
                    .padding()
            }
            Spacer()
            Button(action: {
                selectedTab = 1
            }) {
                Text("레시피")
                    .foregroundColor(selectedTab == 1 ? .orange : .gray)
                    .padding()
            }
        }
        .background(Color.white)
        .shadow(radius: 2)
    }
}

struct IngredientView: View {
    let ingredient: Recipe

    var body: some View {
        Text(ingredient.recipeName)
            .font(.headline)
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

struct RecipesView: View {
    @Binding var recipes : [Recipe]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(recipes) { recipe in
                        SearchRecipeView(recipe: recipe)
                    }
                }
                .padding()
            }
            .navigationTitle("Recipes")
        }
    }
}
struct SearchRecipeView: View {
    let recipe: Recipe

    var body: some View {
        VStack {
//            Image(recipe.imageName)
//                .resizable()
//                .scaledToFit()
//                .frame(height: 100)
            Text(recipe.recipeName)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.vertical, 5)
            HStack {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
                Text("\(recipe.likeCount)")
                    .font(.subheadline)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
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
        .cornerRadius(15)
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
