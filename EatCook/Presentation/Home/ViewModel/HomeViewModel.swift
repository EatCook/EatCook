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
//            InterestingFoods(postId: 79, postImagePath: "image/post/9/79/c0ddc92b-94cd-445c-90cf-294973c35755.jpeg", recipeName: "오므라이스", recipeTime: 15, profile: "image/user/9/26934479-074d-4eb6-a004-00eb6455c7ef.jpeg", nickName: "버럭이", likedCounts: 0, likedCheck: false, archiveCheck: false)
//
//        ]
//        ,
//
//        "분식" :  [
//            InterestingFoods(postId: 0, postImagePath: "test", recipeName: "test", recipeTime: 15, profile: "test", nickName: "nick", likedCounts: 15, likedCheck: false, archiveCheck: false)
//
//
//        ]
    ]
    
    @Published var userCookingTheme : [String : String] = [
        :
//        "WESTERN_FOOD": "양식" , "BUNSIK": "분식"
    ]
    @Published var interestCurrentTab = ""
    @Published var userNickName : String? = ""
    
    
    @Published var recommendCookingTheme : [String : String] = ["DIET" : "다이어트만 n번째", "HEALTH_DIET" : "건강한 식단관리", "CONVENIENCE_STORE" : "편의점은 내 구역", "DELIVERY_FOOD" : "배달음식 단골고객", "MEAL_KIT" : "밀키트 lover"]
    
    var recommendType : [String] = ["DIET", "HEALTH_DIET" , "CONVENIENCE_STORE", "DELIVERY_FOOD", "MEAL_KIT"]
    @Published var recommendFoods : [String : [RecommendFoods]] = ["다이어트만 n번째" : [] , "건강한 식단관리" : [] , "편의점은 내 구역" : [] , "배달음식 단골고객" : [], "밀키트 lover" : []]
    
    
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
                    self.userNickName = result.data?.nickName
                    if userCookingTheme.count > 0 {
                        self.interestCurrentTab = userCookingTheme.first?.key ?? ""
                    }
                    
                    for type in userCookingTheme.keys {
                        self.getUserInterest(type: type)
                    }
                    
                    for type in self.recommendType {
                        self.getUserSpecial(type: type)
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
        MainService.shard.getUserSpecial(type : type , success: { result in
            print("getUserSpecial" ,result)
            DispatchQueue.main.async {
                let key = self.recommendCookingTheme[type]
                self.recommendFoods[key ?? ""] = result.data?.homeInterestDtoList.map { RecommendFoods(postId: $0.postId, postImagePath: $0.postImagePath, recipeName: $0.recipeName, recipeTime: $0.recipeTime, likedCounts: $0.likedCounts, likedCheck: $0.likedCheck, archiveCheck: $0.archiveCheck)}
            }
            
            
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

struct RecommendFoods : Identifiable, Hashable  {
    var id = UUID()
    
    let postId : Int
    let postImagePath : String
    let recipeName : String
    let recipeTime : Int
    let likedCounts : Int
    let likedCheck : Bool
    let archiveCheck : Bool

    
    static func ==(lhs: RecommendFoods, rhs: RecommendFoods) -> Bool {
       return lhs.id == rhs.id
     }
     func hash(into hasher: inout Hasher) {
       hasher.combine(id)
     }
}



