//
//  SearchView.swift
//  EatCook
//
//  Created by 이명진 on 2/8/24.
//

import SwiftUI

struct SearchView: View {
    
    let gridRank = Array(repeating: GridItem(.flexible()), count: 4)
    let gridKeyword = [GridItem(.flexible())]
    
    @State var searchText = ""
    @State var isSearching = false
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    HStack {
                        Text("최근 검색어")
                            .font(.title3)
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            Text("전체 삭제")
                                .font(.body)
                                .foregroundColor(.gray)
                        })
                    }.padding(.vertical, 12)
                    .padding(.horizontal, 16)

                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: gridKeyword) {
                            ForEach(SearchView.testDataKeyword, id: \.self) { title in
                                Button(action: {
                                    
                                }, label: {
                                    Text(title)
                                    
                                    Button {
                                        
                                    } label: {
                                        Image(systemName: "xmark")
                                            .resizable()
                                            .frame(width: 10, height: 10)
                                    }
                                })
                                .frame(height: 38)
                                .padding(.horizontal, 12)
                                .background(Color.bdInactive)
                                .cornerRadius(8)
                            }
                        }.frame(height: 38)
                        .padding(.bottom, 16)
                    }.padding(.leading, 16)
                }.background(Color.white)
                .padding(.bottom, 12)

                VStack {
                    HStack {
                        Text("전날 검색 순위")
                            .font(.title3)
                        Spacer()
                    }.padding(.vertical, 20)
                    .padding(.horizontal, 16)
                    
                    LazyHGrid(rows: gridRank, spacing: 55) {
                        ForEach(SearchView.testDataRank.indices, id: \.self) { index in
                            Button(action: {
                                
                            }, label: {
                                HStack {
                                    Text("\(index + 1)")
                                        .bold()
                                    Text(SearchView.testDataRank[index])
                                        .multilineTextAlignment(.leading)
                                        .frame(height: 38)
                                    Spacer()
                                }
                            })
                        }
                    }.padding(.trailing, 30)
                }.padding(.bottom, 30)
                .background(Color.white)
                
                Spacer()
            }.padding(.top, 30)
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.bgPrimary)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        TextField("재료 또는 레시피를 검색해 보세요                      ", text: $searchText)
                            .frame(maxWidth: .infinity)
                            .padding(.trailing, 4)

                        Spacer()
                        
                        Button(action: {

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
        "생크림"
    ]
}

#Preview {
    SearchView()
}
