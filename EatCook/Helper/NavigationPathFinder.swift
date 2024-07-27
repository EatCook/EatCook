//
//  NavigationPathFinder.swift
//  EatCook
//
//  Created by 이명진 on 3/3/24.
//

import SwiftUI

enum ViewOptions: Hashable {
    case recipeCreate(_ data: String)
    case recipeTag(_ data: RecipeCreateViewModel)
    case recipeStep(_ data: RecipeCreateViewModel)
    case recipeDetail(_ postId: Int)
    
    case setting
    case userProfileEdit
    case userFavoriteTagEdit
    case userWithDraw
    
    case myPage
    case otherUserProfile
    
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .recipeDetail(let postId): RecipeView(postId: postId).toolbarRole(.editor)
        case .recipeCreate: RecipeCreateView().toolbarRole(.editor)
        case .recipeTag(let viewModel): RecipeTagView(viewModel: viewModel).toolbarRole(.editor)
        case .recipeStep(let viewModel): RecipeStepView(viewModel: viewModel).toolbarRole(.editor)
            
        case .setting: SettingView().toolbarRole(.editor)
        case .userProfileEdit: UserProfileEditView().toolbarRole(.editor)
        case .userFavoriteTagEdit: UserFavoriteTagEditView().toolbarRole(.editor)
        case .userWithDraw: UserWithDrawView().toolbarRole(.editor)
            
        case .myPage: UserProfileView().toolbarRole(.editor)
        case .otherUserProfile: OtherUserProfileView().toolbarRole(.editor)
        }
    }
    
    static func == (lhs: ViewOptions, rhs: ViewOptions) -> Bool {
        switch (lhs, rhs) {
        case (.recipeCreate(let lhsData), .recipeCreate(let rhsData)):
            return lhsData == rhsData
        case (.recipeTag(let lhsViewModel), .recipeTag(let rhsViewModel)):
            return lhsViewModel == rhsViewModel
        case (.recipeStep(let lhsData), .recipeStep(let rhsData)):
            return lhsData == rhsData
        case (.recipeDetail(let lhsPostId), .recipeDetail(let rhsPostId)):
            return lhsPostId == rhsPostId
        case (.setting, .setting):
            return true
        case (.userProfileEdit, .userProfileEdit):
            return true
        case (.userFavoriteTagEdit, .userFavoriteTagEdit):
            return true
        case (.userWithDraw, .userWithDraw):
            return true
        case (.myPage, .myPage):
            return true
        case (.otherUserProfile, .otherUserProfile):
            return true
            
            
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .recipeCreate(let data):
            hasher.combine("recipeCreate")
            hasher.combine(data)
        case .recipeTag(let viewModel):
            hasher.combine("recipeTag")
            hasher.combine(viewModel)
        case .recipeStep(let data):
            hasher.combine("recipeStep")
            hasher.combine(data)
        case .recipeDetail(let postId):
            hasher.combine("recipeDetail")
            hasher.combine(postId)
        case .setting:
            hasher.combine("setting")
        case .userProfileEdit:
            hasher.combine("userProfileEdit")
        case .userFavoriteTagEdit:
            hasher.combine("userFavoriteTagEdit")
        case .userWithDraw:
            hasher.combine("userWithDraw")
        case .myPage:
            hasher.combine("myPage")
        case .otherUserProfile:
            hasher.combine("otherUserProfile")
        }
    }
}

final class NavigationPathFinder: ObservableObject {
    @Published var path: NavigationPath = .init()
    
    static let shared = NavigationPathFinder()
    private init() { }
    
    func addPath(_ option: ViewOptions) {
        path.append(option)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func popToRoot() {
        path = .init()
    }
}
