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
    
//  TODO : 한식 일식 야식 별로 서버 데이터 세팅
    @State private var interestingFoods : [interestingFoods] = [
                    interestingFoods(title: "간장 마늘 치킨", user: "나는쉐프다", image: Image(.testFood1)),
                    interestingFoods(title: "아보카도 샐러드", user: "하루집밥살이", image: Image(.testFood1)),
                    interestingFoods(title: "소고기 미트볼", user: "헝그리맨", image: Image(.testFood1)),
                    interestingFoods(title: "깍두기 소고기 비빕밥", user: "배고팡팡", image: Image(.testFood1))
    ]
    
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
        NavigationStack {
            ZStack(alignment : .top) {
                Color.primary7.edgesIgnoringSafeArea(.top)
                ScrollView(.vertical, showsIndicators: false) {

                    HomeMenuTopView()
 
                    VStack(spacing: 20) {
                        HomeInterestingView(interestingFoods: $interestingFoods)
                        
  
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
                                                    Image(.food)
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
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.bgPrimary)
                .padding(.top)
            }
        }
    }
}

struct HomeMenuTopView : View {
    var body: some View {
        
            ZStack {
                VStack {
                    HStack {
                        Image(.logoWhite)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 45)
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }) {
                            Image(.bellWhite)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 24, height: 24)
                        }
                    }.padding(.horizontal, 24)
                    .padding(.top, 15)
                    
                    VStack {
                        Spacer()
                        
                        NavigationLink(destination: SearchView().toolbarRole(.editor)) {
                            HStack {
                                Text("재료 또는 레시피를 검색해 보세요")
                                    .font(.callout)
                                    .padding(.leading, 12)
                                    
                                Spacer()
                                HStack {
                                 
                    
                                    Image(.searchPrimary)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24)
                                }.padding()
                            }.frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.gray)
                                .background(Color.white)
                                .cornerRadius(10)
                                .padding(.horizontal, 22)
                        }
                    }.padding(.bottom, 24)
                    .padding(.top, 12)
                }.background{
                    Color.primary7
                }
            }
            

            
        }
    
}


struct HomeInterestingView : View {
    
    //TODO : 서버값 연결
    var interestingTabs = ["한식", "일식" , "야식"]
    @State var currentTab = "한식"
    
    @Binding var interestingFoods : [HomeView.interestingFoods]
//    var foodThemecolumns : [cook]
    
    var body: some View {
        VStack {
            VStack {
                VStack {
                    HStack {
                        Text("김잇쿡님의 관심 요리")
                            .bold()
                            .font(.system(size: 24))
                        
                        Spacer()
                        
                        
                    }.padding(.top, 25)
                        .padding(.bottom, 8)
                    
                    HStack {
                        ForEach(interestingTabs, id : \.self) { tab in
                            Button(action: {
                                currentTab = tab
                            }) {
                                Text(tab)
                                    .fontWeight(.bold)
                                    .foregroundColor(currentTab == tab ? .white : .gray)
                            }.buttonStyle(.borderedProminent)
                                .tint(currentTab == tab ? .primary7 : .gray2)
                            
                        }
                        Spacer()
                    }.padding(.top , 12)
                        .padding(.leading , 0)
                }.padding(.horizontal, 12)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    LazyHStack(alignment : .top){
                        //TODO : ForEach 데이터 세팅
//                        List($interestingFoods, id : \.self) { interestingFood in
//
//                            interestingRowView(foodName: interestingFood.title, time:interestingFood.time, userImage: interestingFood.userImage, foodImage: interestingFood.image, userName: interestingFood.user)
//             
//                            
//                        }
//                        
//                        ForEach($interestingFoods, id: \.self) { interestingFood in
//                            interestingRowView(foodName: interestingFood.title, time:interestingFood.time, userImage: interestingFood.userImage, foodImage: interestingFood.image, userName: interestingFood.user)
//                        }
                        
                        ForEach(1..<4) { _ in
                            interestingRowView(foodName: "음식이름", time: "시간", userImage: Image(.testUserImage1), foodImage: Image(.testFood1), userName: "유저이름")
                        }
                        
                        
                        
                    }
                       
                }
                
            }.padding(.bottom, 22)
            .background(Color.white)
            
            
            
        }

            
    }
    
}

struct interestingRowView : View {
    
//    @Binding var foodName : String
//    @Binding var time : String
//    @Binding var userImage : Image
//    @Binding var foodImage : Image
//    @Binding var userName : String
    
    var foodName : String
    var time : String
    var userImage : Image
    var foodImage : Image
    var userName : String
    
    
    var body: some View {
        VStack(alignment : .leading) {
   
            ZStack(alignment: .topLeading) {
                foodImage.resizable().frame(width : 220, height : 165)
      
                Image(.bellWhite).resizable().frame(width : 30, height: 30)
//                ZStack(alignment: .bottomTrailing) {
//                    Image(.bookMark).resizable().frame(width : 30, height: 30)
//                }
                
            }
    
            HStack {
                Text(foodName)
                    .font(.system(size : 18))
                    .font(.callout)
                    .bold()
                Spacer()
                HStack {
                    Image(.stopWatch).resizable().frame(width : 20, height: 20)
                    Text(time).font(.system(size : 14)).font(.callout).foregroundColor(.gray5)
                }
     
            }
            HStack {
                userImage.resizable().frame(width : 20, height: 20)
//                Spacer()
                Text("유저 이름").foregroundColor(.black)
            }
          
        }.padding(.horizontal, 6)
    }
}


struct HomeRecommendView : View {
    var body: some View {
        VStack {
            
            
        }

            
    }
    
}






extension HomeView {
    static let testFoodThemeData = ["한식", "일식", "중식", "양식", "안주"]
    static let menuRecommend = ["실시간 인기🔥", "만원의 행복", "본격 자취요리", "편의점"]
    
    struct cookTalk {
        var id = UUID()
        var title: String
        var user: String
        var userImage = Image(.food)
        var image: Image
        var time = "15분"
        var description = "오늘 냉장고 재료로 만든 요리. 치킨과 바질의 어마어마한 조합이 만들어진다. 너무 맛있어서 소분해놓았다! 이렇게 저렇게 글이 길어지면 잘리나 보자. 배고프다 배고파. 오늘 저녁은 카레다!"
        
        static let testFoodData: [cookTalk] = [
            cookTalk(title: "까르보나라 파스타", user: "꽁꽁꽁", image: Image(.food)),
            cookTalk(title: "마라샹궈", user: "손시려", image: Image(.food)),
            cookTalk(title: "계란볶음밥", user: "발시려", image: Image(.food)),
            cookTalk(title: "토마토 파스타", user: "당근당근", image: Image(.food)),
            cookTalk(title: "마라탕", user: "문고리", image: Image(.food)),
            cookTalk(title: "짜장볶음밥", user: "김치냉장고", image: Image(.food))
        ]
    }
    
    struct interestingFoods : Identifiable, Hashable  {
        var id = UUID()
        var title: String
        var user: String
        var userImage = Image(.food)
        var image = Image(.testFood1)
        var time = "15분"
        var bookMark : Bool = false
        
        static func ==(lhs: interestingFoods, rhs: interestingFoods) -> Bool {
           return lhs.title == rhs.title && lhs.user == rhs.user
         }
         func hash(into hasher: inout Hasher) {
           hasher.combine(title)
           hasher.combine(user)
         }
       
        
    }


    
    
    
}



#Preview {
    HomeView()
}
