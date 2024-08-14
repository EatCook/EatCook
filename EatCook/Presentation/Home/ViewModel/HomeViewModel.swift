//
//  HomeViewModel.swift
//  EatCook
//
//  Created by 이명진 on 2/8/24.
//

import Foundation
import SwiftUI
import Combine
import UIKit

class HomeViewModel : ObservableObject {
    
    private let homeUseCase : HomeUseCase
    private var cancellables = Set<AnyCancellable>()
    
    let loginUserInfo: LoginUserInfoManager
    
    
    init(homeUseCase: HomeUseCase , loginUserInfo: LoginUserInfoManager) {
        self.homeUseCase = homeUseCase
        self.loginUserInfo = loginUserInfo
        getUserInfo()
    }
    
    @Published var isTokenError : Bool = false
    @Published var addSignUpNavigate : Bool = false
    
    
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
    @Published var recommendFoods : [String : [RecommendFoods]] = [:]

    
    @Published var recommendSelectedIndex: Int = 0
    @Published var recommendTabViewCount : Int = 0
    @Published var recommendTabViewHeightHeight : Int = 240
    @Published var isFetching: Bool = false
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    @State var frameSize: CGFloat = 500
//    DIET("다이어트만 n번째")
//    HEALTH_DIET("건강한 식단관리")
//    CONVENIENCE_STORE("편의점은 내 구역")
//    DELIVERY_FOOD("배달음식 단골고객")
//    MEAL_KIT("밀키트 lover")
    
    private func getUserData(){
        loginUserInfo.responseUserInfo { userInfo in
            print("userInfo ::::" , userInfo)
            if userInfo.nickName == "" {
                self.addSignUpNavigate = true
            }
        }
    }
    
    
    

    private func getUserInfo() {
        homeUseCase.userInfo()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("메인페이지 UserInfo Setting Finished")
                    
                case .failure(let error):
                    print("error:", error)
                    switch error {
                    case .unauthorized:
                        print("로그인 경로로")
                        self.isTokenError = true
                    default:
                        print("기본 에러처리")
                    }
                    
                    print("MainUserInfoResponse Error: \(error)")
                }
                
            } receiveValue: { response in
                print("메인페이지 UserInfo response:" , response)
                if let userCookingTheme = response.data?.userCookingTheme {
                    self.userCookingTheme = userCookingTheme
                    self.userNickName = response.data?.nickName
                    if userCookingTheme.count > 0 {
                        self.interestCurrentTab = userCookingTheme.first?.key ?? ""
                    }
                    for type in userCookingTheme.keys {
                        self.getUserInterest(type: type)
                    }
                    
//                    Type들을 다 쏴서(DIET , HEALTH_DIET , CONVENIENCE_STORE ... ) 빈값이 없는것만 세팅해줌
                    for type in self.recommendType {
                        self.getUserSpecial(type: type)
                    }
                    
                }
                
            }
            .store(in: &cancellables)
        
        
        
    }
    
    
    
    
    private func getUserInterest(type : String) {
        homeUseCase.cookingTheme(type)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("메인페이지 cookingTheme Setting Finished")
                    
                case .failure(let error):
                    print("cookingTheme Error: \(error)")
                }
                
            } receiveValue: { response in
                if let _ = self.interestingFoods[type] {
                }else{
                    DispatchQueue.main.async {
                        let key = self.userCookingTheme[type]
                        if let key = key {
                            self.interestingFoods[key] = response.data.homeInterestDtoList.map { InterestingFoods(postId: $0.postId, postImagePath: $0.postImagePath, recipeName: $0.recipeName, recipeTime: $0.recipeTime, profile: $0.profile, nickName: $0.nickName, likedCounts: $0.likedCounts, likedCheck: $0.likedCheck, archiveCheck: $0.archiveCheck)}
                        }
                    }
                }
                }
            .store(in: &cancellables)
    }
    
    private func getUserSpecial(type : String) {
        homeUseCase.lifeType(type)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("메인페이지 lifeType Setting Finished")
                    
                case .failure(let error):
                    print("메인페이지 lifeType Error: \(error)")
                }
                
            } receiveValue: { response in
                DispatchQueue.main.async {
                    let key = self.recommendCookingTheme[type]
                    
                    if response.data?.homeInterestDtoList.count != 0 {
                        if self.recommendTabViewCount < response.data?.homeInterestDtoList.count ?? 0 {
                            self.recommendTabViewCount = response.data?.homeInterestDtoList.count ?? 0
                        }
                        
                        self.recommendFoods[key ?? ""] = response.data?.homeInterestDtoList.map { RecommendFoods(postId: $0.postId, postImagePath: $0.postImagePath, recipeName: $0.recipeName, recipeTime: $0.recipeTime, introduction: $0.introduction ,likedCounts: $0.likedCounts, likedCheck: $0.likedCheck, archiveCheck: $0.archiveCheck)}
                    }
                    
                    
                }
                
            }
            .store(in: &cancellables)
        
    }
    
    func fetchItems(){
        guard !isFetching else { return }
        isFetching = true
        feedbackGenerator.impactOccurred()
        getUserData()
        getUserInfo()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isFetching = false
        }
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
    let introduction : String
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



