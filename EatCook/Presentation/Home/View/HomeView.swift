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
    @State private var scrollOffset: CGFloat = 0
    
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
        UISegmentedControl.appearance().backgroundColor = .clear
        UISegmentedControl.appearance().setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        //선택
        UISegmentedControl.appearance().selectedSegmentTintColor = .black
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    var body: some View {

        NavigationStack {
            ZStack(alignment : .top) {
                GeometryReader { geometry in
                    
                    Color.primary7.opacity(scrollOffset > 50 ? 1 : 0).edgesIgnoringSafeArea(.top).animation(.easeInOut)

                    ScrollView(.vertical, showsIndicators: false) {
                        
                 

                        HomeMenuTopView()
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
                            HomeInterestingView(interestingFoods: $interestingFoods)
                            HomeRecommendView()
                           
                            

                        }
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.bgPrimary)
                    .padding(.top)
                    
                }

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
                        ForEach($interestingFoods, id: \.self) { interestingFood in
                            interestingRowView(foodName: interestingFood.title, time:interestingFood.time, userImage: interestingFood.userImage, foodImage: interestingFood.image, userName: interestingFood.user)
                        }
                   
                    }
                       
                }
                
            }.padding(.bottom, 22)
            .background(Color.white)
            
            
            
        }

            
    }
    
}

struct interestingRowView : View {
    
    @Binding var foodName : String
    @Binding var time : String
    @Binding var userImage : Image
    @Binding var foodImage : Image
    @Binding var userName : String
    
    var body: some View {
        VStack(alignment : .leading) {
   
            ZStack(alignment: .topLeading) {
                ZStack(alignment : .bottomTrailing) {
                    foodImage.resizable().frame(width : 220, height : 165)
                    Image(.bookMark).resizable().frame(width: 20 , height:  24).padding()
                }
               
                HStack {
                    Image(.whiteHeart).resizable().frame(width: 20 , height: 20)
                    Text("120").font(.callout).foregroundColor(.white)
                }
                .padding(.vertical, 3)
                .padding(.horizontal, 5)
                .background(Color.black.opacity(0.2))
                    .cornerRadius(5)
                    .padding(12)
            }
    
            HStack {
                Text(foodName)
                    .font(.system(size : 18))
                    .font(.callout)
                    .bold()
                Spacer()
//                HStack {
//                    Image(.stopWatch).resizable().frame(width : 20, height: 20)
//                    Text(time).font(.system(size : 14)).font(.callout).foregroundColor(.gray5)
//                }
     
            }
            HStack {
                userImage.resizable().frame(width : 20, height: 20)
                Text("유저 이름").foregroundColor(.black)
            }
          
        }.padding(.horizontal, 6)
    }
}


struct HomeRecommendView : View {
    
    
    //TODO : 서버값 연결
    @State var recommendTabs = ["건강 요리", "다이어트 요리" , "배달음식 요리", "편의점 요리", "밀키트 요리"]
    @State var selectedIndex = 0
    
    @State private var tabHeight: CGFloat = 1
    @State var initialHeight: CGFloat = 0
    @State var sizeArray: [CGSize] = [CGSize(width: 300, height: 5 * 230), CGSize(width: 300, height: 10 * 230), CGSize(width: 300, height: 3 * 230), CGSize(width: 300, height: 15 * 230), CGSize(width: 300, height: 20 * 230)]
    
    
    @State var viewArray : [VStack] = [VStack {
        RecommendColArrView(count: 5)
    }, VStack{
        RecommendColArrView(count: 10)
        } , VStack{
            RecommendColArrView(count: 3)
        } , VStack{
            RecommendColArrView(count: 15)
        } , VStack{
            RecommendColArrView(count: 20)
        }]
//    var viewHeight : [Int] = [5,10,3,15,20]
//
//    // 배열의 길이에 따라 동적으로 계산된 높이 반환하는 함수
//    func dynamicHeight() -> CGFloat {
//        let itemCount = CGFloat(viewHeight[selectedIndex])
//        let minHeight: CGFloat = 250 // 최소 높이
//        let totalHeight = itemCount * minHeight
//        return totalHeight
//    }
    
    
    var body: some View {
        VStack {
            VStack{
                
                HStack {
                    Text("김잇쿡님의 관심 요리")
                        .bold()
                        .font(.system(size: 24))
                    Spacer()
                }
                
                LazyVStack(spacing: 12, pinnedViews: [.sectionHeaders]) {
                    Section {
                        VStack {
                                TabView(selection : $selectedIndex) {
                                    ForEach(0..<viewArray.count , id : \.self){ index in
                                        viewArray[index].fixedSize().readSize { size in
                                            print("size ::::", size)
                                            sizeArray[index] = size
                                            if initialHeight == 0 {
                                                initialHeight = size.height
                                            }
                                        }
                                    }
                
                                }
                                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                                .frame(height: tabHeight)
                                .onChange(of: selectedIndex) { newValue in
                                    print(sizeArray)
                                    print("selectedIndex :::", selectedIndex)
                                    print("newValue :::" , newValue)
                                    withAnimation {
                                        tabHeight = sizeArray[newValue].height
                                    }
                                }
                                .onChange(of: initialHeight) { newValue in
                                    print("newValue" , newValue)
                                    tabHeight = newValue
                                }
                        }
                        
                    }
                header: {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack{
                                ForEach(Array(recommendTabs.enumerated()), id: \.offset) { index, element in
                                  // ...
                                    Button(action: {
                                        withAnimation(.easeInOut){
                                            selectedIndex = index
//                                            print(selectedIndex)
                                        }
                                    }) {
                                        Text(element)
                                            .padding(.vertical, 4)
                                            .fontWeight(.bold)
                                            .foregroundColor(selectedIndex == index ? .white : .gray)
                                        
                                    }.buttonStyle(.borderedProminent)
                                        .tint(selectedIndex == index ? .primary7 : .gray2).animation(.easeInOut)
                                }
                                
                            }
                        }
                    }
                    
                }

                                         
            }.padding(.horizontal, 10)
    

            
            
        }.background{
            Color.white
        }

            
    }
    
}

struct RecommendColArrView : View {
    
    var count : Int
    
    var body: some View {
        VStack{
            ForEach(0..<count , id : \.self){ _ in
                RecommendColView()
            }
        }
   
    }
    
}




struct RecommendColView : View {
    
    var body: some View {
        VStack(alignment : .leading) {
//            이미지
            ZStack(alignment: .topLeading){
                ZStack(alignment : .bottomTrailing){
                    Image(.testFood2).resizable().frame(height:  160)
                    Image(.bookMark).resizable().frame(width: 20 , height:  24).padding()
                }
               
                HStack {
                    Image(.whiteHeart).resizable().frame(width: 20 , height: 20)
                    Text("120").font(.callout).foregroundColor(.white)
                }
                .padding(.vertical, 3)
                .padding(.horizontal, 5)
                .background(Color.black.opacity(0.2))
                    .cornerRadius(5)
                    .padding(12)
                    
            }
            
//            타이틀 시간
            HStack {
                Text("음식 이름")
                    .bold()
                    .font(.system(size: 24))
                
                Image(.stopWatch).resizable().frame(width : 20, height: 20)
                Text("시간").font(.system(size : 14)).font(.callout).foregroundColor(.gray5)
                
                Spacer()
            }
//            설명
            VStack{
                Text("간장을 끓이지않고 냉동새우로 간장 새우장 만드는 법을 알려줄게요 :)").font(.system(size : 14)).font(.callout).foregroundColor(.gray8)
            }
            
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
        var userImage = Image(.testUserImage1)
        var image = Image(.testFood1)
        var time = "15분"
        var bookMark : Bool = false
        
        static func ==(lhs: interestingFoods, rhs: interestingFoods) -> Bool {
           return lhs.id == rhs.id
         }
         func hash(into hasher: inout Hasher) {
           hasher.combine(id)
         }
       
        
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
