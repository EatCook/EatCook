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
    @State var topRankData : [String] = []
    
    @State var recentSearchData : [[String]] = [["홍고추"],["계란덮밥", "덮밥"], ["감바스","마늘","고추"],["감바스","마늘","고추", "양배추"],["감바스","마늘","고추", "양배추", "닭갈비"]]
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
    //                최근 검색어 VIEW
                    ZStack(alignment : .top) {
                        VStack {
                            HStack(alignment: .bottom) {
                                Text("지금 많이 검색하고 있어요")
                                    .font(.title3).bold()
                                Text("2024.03.13")
                                    .foregroundColor(.gray5)
                                    .font(.system(size: 12))
                                
                                Spacer()
                            }.padding(.vertical, 20)
                            .padding(.horizontal, 16)
                            
                            LazyVStack(alignment: .trailing){
                                ForEach(SearchView.testDataRank.indices, id : \.self) { index in
                                    Button(action: {
                                        
                                    }, label: {
                                        HStack {
                                            
                                            index+1 > 3 ?
                                            HStack(spacing : 24) {
                                                Text("\(index + 1)").foregroundColor(.secondary).bold()
                                                Text(SearchView.testDataRank[index]).font(.system(size: 18))

                                            }.padding(.vertical, 12)
                                            :
                                            HStack(spacing : 24) {
                                                Text("\(index + 1)").foregroundColor(.primary6)
                                                    .bold()
                                                Text(SearchView.testDataRank[index]).font(.system(size: 18)).bold()

                                                
                                            }.padding(.vertical, 12)
                                            

                                            Spacer()
                                            Image(.upPrimary)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 18)
                                        }
                                    })
                                }
                            }.padding(.horizontal, 16)

                            Spacer()
                            
                            
                        }.padding(.bottom, 30)
                        .background(Color.white)
                        
                        if isSearching {
                            VStack(alignment : .leading, spacing: 0){
                               
                                RecentSearchView(recentSearchData : $recentSearchData)
                                    
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
                    



                    
                }.padding(.top, 15)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.white)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack {
                            TextField("재료 또는 레시피를 검색해 보세요                       ", text: $searchText)
                                .frame(maxWidth: .infinity)
                                .padding(.trailing, 4)
                                .onTapGesture {
                                    withAnimation {
                                        isSearching = true
                                    }
                                }
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    isSearching = true
                                }
                            }) {
                                Image(systemName: "magnifyingglass")
                                    .tint(.gray)
                            }
                        }
                       
                        
                    }
                }
                
            }

        }
    }
}

struct RecentSearchView: View {
    @State  var searchText = ""
    @Binding  var recentSearchData : [[String]]
    
    var body: some View {
                        VStack {
                            HStack {
                                Text("최근 검색어")
                                    .font(.title3)
                                    .bold()
        
                                Spacer()
        
                                Button(action: {
                                    recentSearchData = []
                                }, label: {
                                    Text("전체 삭제")
                                        .font(.body)
                                        .foregroundColor(.gray)
                                })
                            }.padding(.vertical, 12)
                            .padding(.horizontal, 16)
        
                            LazyVStack(alignment : .leading) {
                                if recentSearchData.count == 0 {
                                    HStack(alignment : .center) {
                                        Text("최근 검색어가 없습니다").font(.system(size : 16)).font(.callout)
                                    }
                                    .frame(maxWidth : .infinity)
                                    .padding(.vertical , 24)
                                }else{
                                    ForEach(recentSearchData, id: \.self) { title in
                                        HStack {
                                            
                                            Image(.search).resizable()
                                                .frame(width: 20, height: 20)
                                            
                                            Button(action: {
                                                print(title)
                                            }, label: {
                                                Text(title.joined(separator: ", ")).font(.system(size : 16)).font(.callout)
                                                
                                                
                                            })
                                            .frame(height: 38)
                                            .padding(.horizontal, 12)
                                            
                                            
                                            Spacer()
                                            Button {
                                                
                                            } label: {
                                                Image(.cancel).resizable()
                                                    .frame(width: 20, height: 20)
                                            }
                                            
                                            
                                        }
                                    }
                                    
                                }
     
                            }
                            .padding(.horizontal , 12)

                            
                        }.background(Color.white)
           
    }
}



//테스트
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
    SearchView()
}
