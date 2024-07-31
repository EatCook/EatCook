//
//  HomeView.swift
//  EatCook
//
//  Created by 이명진 on 2/7/24.
//

import SwiftUI

struct HomeView: View {

    @State private var scrollOffset: CGFloat = 0
    @StateObject private var homeViewModel = HomeViewModel()

    init() {
        //기본
        UISegmentedControl.appearance().backgroundColor = .clear
        UISegmentedControl.appearance().setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        //선택
        UISegmentedControl.appearance().selectedSegmentTintColor = .black
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    var body: some View {

//        NavigationStack {
            ZStack(alignment : .top) {
                GeometryReader { geometry in
                    
                    Color.primary7.opacity(scrollOffset > 50 ? 1 : 0).edgesIgnoringSafeArea(.top).animation(.easeInOut)
                    ScrollViewReader { ScrollViewProxy in
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            HomeMenuTopView()
                
                            
                            NavigationLink(destination: LoginView().toolbarRole(.editor)) {
                                Text("로그인 뷰")
                                    .bold()
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 55)
                                    .background(Color.bdActive)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 24)
                            }
                          
                            
                            GeometryReader { scrollViewGeometry in
                                   Color.clear.onAppear {
                                       scrollOffset = scrollViewGeometry.frame(in: .global).minY
                                   }
                                   .onChange(of: scrollViewGeometry.frame(in: .global).minY) { newValue in
                                       withAnimation {
                                           scrollOffset = newValue
                                       }
                                   }
                               }
       
                            VStack(spacing: 20) {
                                HomeInterestingView()
                                Color.gray2.frame(height : 10)
                                HomeRecommendView().onChange(of: homeViewModel.recommendSelectedIndex) { _ in
                                    withAnimation {
                                        ScrollViewProxy.scrollTo("TabViewSection", anchor: .top)
                                    }
                                }
                                

                            }
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.white)
                        .padding(.top)
                        
                        
                    }
                
                    
                }

            }.environmentObject(homeViewModel)

//        }
//        .toolbar(.hidden, for: .navigationBar)
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
        
    
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    var body: some View {
        VStack {
            VStack {
                
                if homeViewModel.interestingFoods.isEmpty {
                    VStack {
                        HStack {
                            VStack(alignment : .leading){
                                Text("내 취향 레시피만 보고싶다면?").bold()
                                    .font(.system(size: 20))
                                Text("나의 관심 요리를 설정해 보세요").foregroundColor(.gray8).font(.system(size: 16))
                            }
                            
                            Spacer()
                            
                            Image(.mainRecipeEmpty).resizable().frame(width: 60 , height: 60)
                            
                            
                        }
                        
       
                    }
                    .padding(.horizontal , 24)
                    .padding(.vertical , 24)
                    
                    .background{
                        Color.gray10
                    }
                    .cornerRadius(10)
                    .padding(.horizontal , 12)
                    
                }else{
                    VStack {
                        HStack {
                            if let userName = homeViewModel.userNickName {
                                Text("\(userName)님의 관심 요리")
                                    .bold()
                                    .font(.system(size: 24))
                            }
  
                            Spacer()
                            
                            
                        }.padding(.top, 25)
                            .padding(.bottom, 8)
                        
                        HStack {
                            ForEach(Array(homeViewModel.userCookingTheme), id: \.key) { key , value in
                                let tab = homeViewModel.userCookingTheme[key]!
                                Button(action: {
                                    homeViewModel.interestCurrentTab = key
                    
                                }) {
                                    Text(tab)
                                        .fontWeight(.bold)
                                        .foregroundColor(homeViewModel.userCookingTheme[homeViewModel.interestCurrentTab] == tab ? .white : .gray)
                                }
                                .buttonStyle(.borderedProminent)
                                .tint(homeViewModel.userCookingTheme[homeViewModel.interestCurrentTab] == tab ? .primary7 : .gray2)
                            }
                            Spacer()
                        }
                        .padding(.top, 12)
                        .padding(.leading, 0)
                    }.padding(.horizontal, 12)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        if let foods = homeViewModel.interestingFoods[homeViewModel.userCookingTheme[homeViewModel.interestCurrentTab] ?? ""] {
                            VStack(alignment: .leading) {
                                LazyHStack(alignment: .top) {
                                    ForEach(foods) { interestingFood in
                                        interestingRowView(postId: interestingFood.postId, postImagePath: interestingFood.postImagePath, recipeName: interestingFood.recipeName, recipeTime: interestingFood.recipeTime, profile: interestingFood.profile, nickName: interestingFood.nickName, likedCounts: interestingFood.likedCounts, likedCheck: interestingFood.likedCheck, archiveCheck: interestingFood.archiveCheck)
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                    
                }
                
            }.padding(.bottom, 22)
            .background(Color.white)
            
            
            
        }

            
    }
    
}

struct interestingRowView : View {
    @StateObject private var mainloader = ImageLoader()
    @StateObject private var userLoader = ImageLoader()
    
    var postId : Int
    var postImagePath : String
    var recipeName : String
    var recipeTime : Int
    var profile : String
    var nickName : String
    var likedCounts : Int
    var likedCheck : Bool
    var archiveCheck : Bool
    
    var body: some View {
        VStack(alignment : .leading) {
  
            
   
            ZStack(alignment: .topLeading) {
                ZStack(alignment : .bottomTrailing) {
                    if let imageUrl = URL(string: "\(Environment.AwsBaseURL)/\(postImagePath)") {
                        ZStack(alignment: .bottomTrailing) {
                            AsyncImage(url: imageUrl) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(height: 165)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width : 220 , height: 165) // 원하는 높이 설정
                                        .clipped()
                                        .cornerRadius(10)
                                case .failure:
                                    LoadFailImageView().frame(width : 220 , height: 165)
                                @unknown default:
                                    EmptyView()
                                }
                            }   
                        }
                    }

                    if archiveCheck {
                        Image(.bookMark).resizable().frame(width: 20 , height:  24).padding()
                    }
                    
                    
                }
               
                HStack {
                    Image(.whiteHeart).resizable().frame(width: 20 , height: 20)
                    Text(String(likedCounts)).font(.callout).foregroundColor(.white)
                }
                .padding(.vertical, 3)
                .padding(.horizontal, 5)
                .background(Color.black.opacity(0.2))
                    .cornerRadius(5)
                    .padding(12)
            }
    
            HStack {
                Text(recipeName)
                    .font(.system(size : 18))
                    .font(.callout)
                    .bold()
                Spacer()
                HStack {
                    Image(.stopwatch).resizable().frame(width : 18, height: 18)
                    Text("\(String(recipeTime))분").font(.system(size : 14)).font(.callout).foregroundColor(.gray5)
                }
     
            }
            HStack {
                if let imageUrl = URL(string: "\(Environment.AwsBaseURL)/\(profile)") {
                    ZStack(alignment: .bottomTrailing) {
                        AsyncImage(url: imageUrl) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width : 20 , height: 20)
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width : 20 , height: 20)
                                    .clipped()
                                    .cornerRadius(10)
                            case .failure:
                                LoadFailImageView() .frame(width : 20 , height: 20)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                }
                Text(nickName).foregroundColor(.black)
            }
        }
        .frame(width: 220 , height: 220)
        .padding(.horizontal, 6)
    }
}


struct HomeRecommendView : View {
    
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    @State var selectedString = ""
    

    
    private var headerSection: some View {
       Section(header:
                   ScrollView(.horizontal, showsIndicators: false) {
           HStack {
               ForEach(Array(homeViewModel.recommendFoods.keys.enumerated()), id: \.offset) { index, element in
                   Button(action: {
                       withAnimation(.easeInOut) {
                           homeViewModel.recommendSelectedIndex = index
                           selectedString = element
                       }
                   }) {
                       Text(element)
                           .padding(.vertical, 4)
                           .fontWeight(.bold)
                           .foregroundColor(homeViewModel.recommendSelectedIndex == index ? .white : .gray)
                   }
                   .buttonStyle(.borderedProminent)
                   .tint(homeViewModel.recommendSelectedIndex == index ? .primary7 : .gray2)
                   .animation(.easeInOut, value: homeViewModel.recommendSelectedIndex)
               }
           }
       }.padding(.bottom, 24)
       ) {
           tabViewSection
       }
   }

    private var tabViewSection: some View {
        TabView(selection: $homeViewModel.recommendSelectedIndex) {
           ForEach(Array(homeViewModel.recommendFoods.keys.enumerated()), id: \.offset) { index, key in
               let foods = homeViewModel.recommendFoods[key]
               RecommendColArrView(foods: foods ?? [])
                   .tag(index)
           }
       }
      
       .tabViewStyle(PageTabViewStyle())
       .frame(height: CGFloat(homeViewModel.recommendTabViewCount) * 300 > 0 ? CGFloat(homeViewModel.recommendTabViewCount) * 300 : 1200)
   }
    
    
    
    var body: some View {
        VStack {
            VStack{
                
                HStack {
                    Text("오늘의 추천 메뉴")
                        .bold()
                        .font(.system(size: 24))
                       
                    Spacer()
                }.id("TabViewSection")
                
                VStack {
                    LazyVStack(spacing: 12, pinnedViews: [.sectionHeaders]) {
                        headerSection
                    }
                }
                          
            }.padding(.horizontal, 10)
    

            
            
        }.background{
            Color.white
        }

            
    }
    
}


struct RecommendColArrView : View {

    
    var foods: [RecommendFoods]
    
    var body: some View {
        VStack(alignment : .leading){
            ForEach(foods) {
                RecommendColView(postId: $0.postId, postImagePath: $0.postImagePath, recipeName: $0.recipeName, recipeTime: $0.recipeTime, likedCounts: $0.likedCounts, likedCheck: $0.likedCheck, archiveCheck: $0.archiveCheck)
            }
            Spacer()
            
        }
    }
    
}




struct RecommendColView : View {
    @StateObject private var mainloader = ImageLoader()
    
    let postId : Int
    let postImagePath : String
    let recipeName : String
    let recipeTime : Int
    let likedCounts : Int
    let likedCheck : Bool
    let archiveCheck : Bool
    
    var body: some View {
        VStack(alignment : .leading) {
//            이미지
            ZStack(alignment: .topLeading){
                ZStack(alignment : .bottomTrailing){
                    if let imageUrl = URL(string: "\(Environment.AwsBaseURL)/\(postImagePath)") {
                        ZStack(alignment: .bottomTrailing) {
                            AsyncImage(url: imageUrl) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(height: 160) // 원하는 높이 설정
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(height: 160) // 원하는 높이 설정
                                        .clipped()
                                        .cornerRadius(10)
                                case .failure:
                                    LoadFailImageView().frame(height: 160)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                    }
                    Image(archiveCheck ? .bookMarkChecked : .bookMark).resizable().frame(width: 18 , height:  24).padding()
                }
               
                HStack {
                    Image(.whiteHeart).resizable().frame(width: 20 , height: 20)
                    Text(String(likedCounts)).font(.callout).foregroundColor(.white)
                }
                .padding(.vertical, 3)
                .padding(.horizontal, 5)
                .background(Color.black.opacity(0.2))
                    .cornerRadius(5)
                    .padding(12)
                    
            }
            

            VStack(alignment : .leading) {
                //            타이틀 시간
                HStack {
                    Text(recipeName)
                        .bold()
                        .font(.system(size: 24))
                    
                    Image(.stopwatch).resizable().frame(width : 20, height: 20)
                    Text("\(recipeTime)분").font(.system(size : 14)).font(.callout)
                    
                        .foregroundColor(.gray5)
                    
                    Spacer()
                }
                //            설명
                VStack{
                    Text("간장을 끓이지않고 냉동새우로 간장 새우장 만드는 법을 알려줄게요 :)")
                        .lineLimit(2)
                        .font(.system(size : 14)).font(.callout).foregroundColor(.gray8)
                }
                
            }.padding(.horizontal, 5)

            
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
    


}

struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
            .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}



#Preview {
    HomeView()
}
