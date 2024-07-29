//
//  HomeViewModel.swift
//  EatCook
//
//  Created by 이명진 on 2/8/24.
//

import Foundation
import SwiftUI


class HomeViewModel : ObservableObject {
    
    @Published var interestingFoods : [String : [InterestingFoods]] = [:
//        "양식" :  [
//            InterestingFoods(title: "간장 마늘 치킨", user: "나는쉐프다", image: Image(.testFood1)),
//            InterestingFoods(title: "아보카도 샐러드", user: "하루집밥살이", image: Image(.testFood1)),
//            InterestingFoods(title: "소고기 미트볼", user: "헝그리맨", image: Image(.testFood1)),
//            InterestingFoods(title: "깍두기 소고기 비빕밥", user: "배고팡팡", image: Image(.testFood1))
//        ]
//        ,
//        
//        "분식" :  [
//            InterestingFoods(title: "일식", user: "나는쉐프다", image: Image(.testFood1)),
//            InterestingFoods(title: "일식드", user: "하루집밥살이", image: Image(.testFood1)),
//            InterestingFoods(title: "소고일식", user: "헝그리맨", image: Image(.testFood1)),
//            InterestingFoods(title: "깍두기 일식", user: "배고팡팡", image: Image(.testFood1))
//        ]
    ]
    
    @Published var userCookingTheme : [String : String] = [
        :
//        "WESTERN_FOOD": "양식" , "BUNSIK": "분식"
    ]
    @Published var interestCurrentTab = ""
    
//    DIET("다이어트만 n번째")
//    HEALTH_DIET("건강한 식단관리")
//    CONVENIENCE_STORE("편의점은 내 구역")
//    DELIVERY_FOOD("배달음식 단골고객")
//    MEAL_KIT("밀키트 lover")
    
    
    
    init() {
     
        MainService.shard.getUserInfo(success: { result in
            print("getUserInfo" ,result)
            DispatchQueue.main.async {
                if let userCookingTheme = result.data?.userCookingTheme{
                    self.userCookingTheme = userCookingTheme
                    if userCookingTheme.count > 0 {
                        self.interestCurrentTab = userCookingTheme.first?.key ?? ""
                    }
                    
                    for type in userCookingTheme.keys {
                        self.getUserInterest(type: type)
                    }
                    
                }
                
            }
            
            
        }, failure: { error in
            print(error)
        })
        
        

        
    }
    
    
    private func getUserInterest(type : String) {
        MainService.shard.getUserInterest(type : type ,success: { result in
            print("getUserInterest" ,result)
            
            if let _ = self.interestingFoods[type] {
                
                
            }else{
                DispatchQueue.main.async {
                    let key = self.userCookingTheme[type]
                    self.interestingFoods[key ?? ""] = result.data.homeInterestDtoList.map { InterestingFoods(postId: $0.postId, postImagePath: $0.postImagePath, recipeName: $0.recipeName, recipeTime: $0.recipeTime, profile: $0.profile, nickName: $0.nickName, likedCounts: $0.likedCounts, likedCheck: $0.likedCheck, archiveCheck: $0.archiveCheck)}
                }
                
                
            }
            
            
        }, failure: { error in
            print(error)
        })
        
        
    }
    
    private func getUserSpecial(type : String) {
        MainService.shard.getUserSpecial(success: { result in
            print("getUserSpecial" ,result)
            
            
            
        }, failure: { error in
            print(error)
        })

        
        
    }
    
    
    
    
}


struct InterestingFoods : Identifiable, Hashable  {
    var id = UUID()
    
    var postId : Int
    var postImagePath : String
    var recipeName : String
    var recipeTime : Int
    var profile : String
    var nickName : String
    var likedCounts : Int
    var likedCheck : Bool
    var archiveCheck : Bool

    
    static func ==(lhs: InterestingFoods, rhs: InterestingFoods) -> Bool {
       return lhs.id == rhs.id
     }
     func hash(into hasher: inout Hasher) {
       hasher.combine(id)
     }
}
