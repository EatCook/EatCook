//
//  TabCase.swift
//  EatCook
//
//  Created by 이명진 on 2/17/24.
//

import SwiftUI

//enum TabCase: Hashable {
//    case feedTab(FeedTabCase)
//    case recipeTab(RecipeTabCase)
//    
//    enum FeedTabCase: CaseIterable {
//        case cooktalk
//        case follow
//        
//        var title: String {
//            switch self {
//            case .cooktalk:
//                return "쿡톡"
//            case .follow:
//                return "팔로우"
//            }
//        }
//        
//        var index: Int {
//            return FeedTabCase.allCases.firstIndex(of: self) ?? 0
//        }
//        
//        var count: Int {
//            return FeedTabCase.allCases.count
//        }
//        
//        @ViewBuilder
//        func tabCaseContainerView() -> some View {
//            switch self {
//            case .cooktalk: Text("쿡톡 피드")
//            case .follow: Text("팔로우 피드")
//            }
//        }
//    }
//    
//    enum RecipeTabCase: CaseIterable {
//        case recipe
//        case ingredients
//        
//        var title: String {
//            switch self {
//            case .recipe:
//                return "레시피"
//            case .ingredients:
//                return "필요한 재료"
//            }
//        }
//        
//        var index: Int {
//            return RecipeTabCase.allCases.firstIndex(of: self) ?? 0
//        }
//        
//        var count: Int {
//            return RecipeTabCase.allCases.count
//        }
//        
//        @ViewBuilder
//        func tabCaseContainerView() -> some View {
//            switch self {
//            case .recipe: RecipeContainerView()
//            case .ingredients: IngredientsContainerView()
//            }
//        }
//    }
//}
