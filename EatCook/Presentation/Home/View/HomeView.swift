//
//  HomeView.swift
//  EatCook
//
//  Created by 이명진 on 2/7/24.
//

import SwiftUI

struct HomeView: View {
    
    @State var search = ""
    @State private var selectFoodTheme = 0
    @State private var selectMenuRecommend = 0
    
    let foodThemecolumns = [GridItem(.flexible())]
    let menuRecommendcolumns = [GridItem(.flexible())]
    
    init() {
        //기본
        //UISegmentedControl.appearance().backgroundColor = .clear
        UISegmentedControl.appearance().setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        //선택
        UISegmentedControl.appearance().selectedSegmentTintColor = .black
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    var body: some View {
//        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                ZStack {
                    Image(.bgHome)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .opacity(0.4)
                        .frame(height: 250)
                    
                    VStack {
                        HStack {
                            Image(.logo)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 45)
                            
                            Spacer()
                            
                            Button(action: {
                                
                            }) {
                                Image(.bell)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 24, height: 24)
                            }
                        }.padding(.horizontal, 24)
                        .padding(.vertical, 11)
                        
                        VStack {
                            Spacer()
                            
                            NavigationLink(destination: SearchView().toolbarRole(.editor)) {
                                ZStack {
                                    Text("재료 또는 레시피를 검색해 보세요")
                                        .font(.callout)
                                    
                                    HStack {
                                        Spacer()
                                        
                                        Image(.search)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20)
                                    }.padding()
                                }.frame(height: 50)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.gray)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .border(.bdBorder, width: 1)
                                    .padding(.horizontal, 22)
                            }
                        }.padding(.vertical, 26)
                    }
                }
                
                VStack(spacing: 15) {
                    VStack {
                        VStack {
                            HStack {
                                Text("OOO님이 관심있는 요리")
                                    .bold()
                                
                                Spacer()
                                
                                Button(action: {
                                    
                                }, label: {
                                    Text("편집")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                })
                            }.padding(.top, 25)
                                .padding(.bottom, 8)
                            
                            Picker("selectFoodTheme", selection: $selectFoodTheme) {
                                ForEach(0..<HomeView.testFoodThemeData.count, id: \.self) { index in
                                    Text(HomeView.testFoodThemeData[index]).tag(index)
                                }
                            }.pickerStyle(.segmented)
                                .padding(.bottom, 22)
                        }.padding(.horizontal, 26)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: foodThemecolumns, spacing: 12) {
                                ForEach(HomeView.cookTalk.testFoodData, id: \.id) { data in
                                    VStack {
                                        ZStack {
                                            data.image
                                                .resizable()
                                                .frame(width: 200, height: 165)
                                                .cornerRadius(10)
                                            
                                            HStack {
                                                Spacer()
                                                
                                                Text(data.time)
                                                    .font(.caption)
                                                    .foregroundColor(.white)
                                                    .background(Color.gray)
                                                    .frame(width: 44, height: 22)
                                            }
                                        }
                                        
                                        HStack {
                                            Text(data.title)
                                                .font(.caption)
                                                .bold()
                                            
                                            Spacer()
                                        }
                                        
                                        HStack {
                                            Image(.userProfile)
                                                .resizable()
                                                .frame(width: 18, height: 18)
                                                .cornerRadius(9)
                                            
                                            Text(data.user)
                                                .font(.caption2)
                                            
                                            Spacer()
                                        }
                                    }
                                }
                            }
                        }.padding(.leading, 26)
                        .frame(maxHeight: .infinity)
                    }.padding(.bottom, 22)
                    .background(Color.white)
                    
                    VStack {
                        VStack {
                            HStack {
                                Text("오늘의 추천메뉴")
                                    .bold()
                                
                                Spacer()
                            }
                            .padding(.bottom, 8)
                            
                            Picker("menuRecommend", selection: $selectMenuRecommend) {
                                ForEach(0..<HomeView.menuRecommend.count, id: \.self) { index in
                                    Text(HomeView.menuRecommend[index]).tag(index)
                                }
                            }.pickerStyle(.segmented)
                                .padding(.bottom, 22)
                        }.padding(.top, 25)
                            .padding(.horizontal, 26)
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVGrid(columns: menuRecommendcolumns, spacing: 12) {
                                ForEach(HomeView.cookTalk.testFoodData, id: \.id) { data in
                                    HStack {
                                        data.image
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                            .cornerRadius(10)
                                        
                                        VStack {
                                            HStack {
                                                Image(.userProfile)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 18, height: 18)
                                                    .cornerRadius(9)
                                                
                                                Text(data.user)
                                                    .font(.caption2)
                                                
                                                Spacer()
                                            }
                                            
                                            HStack {
                                                Text(data.title)
                                                    .font(.callout)
                                                    .bold()
                                                
                                                Spacer()
                                            }
                                            Text(data.description)
                                                .font(.body)
                                                .lineLimit(nil)
                                        }
                                    }.frame(height: 120)
                                    .padding(.horizontal, 10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.bdBorder, lineWidth:1)
                                    )
                                }
                            }
                        }.padding(.horizontal, 22)
                        .frame(maxHeight: .infinity)
                        .gesture(
                            DragGesture()
                                .onEnded { gesture in
                                    let dragDistance = gesture.translation.width
                                    print("dragDistance", dragDistance)
                                    if dragDistance > 0 {
                                        //오른쪽으로 스와이프
                                        guard selectMenuRecommend > 0 else { return }
                                        selectMenuRecommend -= 1
                                    } else {
                                        guard selectMenuRecommend < 3 else { return }
                                        selectMenuRecommend += 1
                                    }
                                }
                        )
                    }.background(Color.white)
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.bgPrimary)
            .padding(.vertical)
//        }
    }
}

extension HomeView {
    static let testFoodThemeData = ["한식", "일식", "중식", "양식", "안주"]
    static let menuRecommend = ["실시간 인기🔥", "만원의 행복", "본격 자취요리", "편의점"]
    
    struct cookTalk {
        var id = UUID()
        var title: String
        var user: String
        var userImage = Image(.userProfile)
        var image: Image
        var time = "15분"
        var description = "오늘 냉장고 재료로 만든 요리. 치킨과 바질의 어마어마한 조합이 만들어진다. 너무 맛있어서 소분해놓았다! 이렇게 저렇게 글이 길어지면 잘리나 보자. 배고프다 배고파. 오늘 저녁은 카레다!"
        
        static let testFoodData: [cookTalk] = [
            cookTalk(title: "까르보나라 파스타", user: "꽁꽁꽁", image: Image(.food1)),
            cookTalk(title: "마라샹궈", user: "손시려", image: Image(.food2)),
            cookTalk(title: "계란볶음밥", user: "발시려", image: Image(.food3)),
            cookTalk(title: "토마토 파스타", user: "당근당근", image: Image(.food1)),
            cookTalk(title: "마라탕", user: "문고리", image: Image(.food2)),
            cookTalk(title: "짜장볶음밥", user: "김치냉장고", image: Image(.food3))
        ]
    }
}

#Preview {
    HomeView()
}
