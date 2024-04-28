//
//  NavigationPathFinder.swift
//  EatCook
//
//  Created by 이명진 on 3/3/24.
//

import SwiftUI

enum ViewOptions: Hashable {
    case recipeCreate(_ data: String)
    case recipeTag(_ data: String)
    case recipeStep(_ data: String)
    case recipeDetail
    
    case setting
    case userProfileEdit
    case userFavoriteTagEdit
    case userWithDraw
    
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .recipeDetail: RecipeView()
        case .recipeCreate: RecipeCreateView()
        case .recipeTag: RecipeTagView()
        case .recipeStep: RecipeStepView()
            
        case .setting: SettingView()
        case .userProfileEdit: UserProfileEditView()
        case .userFavoriteTagEdit: UserFavoriteTagEditView()
        case .userWithDraw: UserWithDrawView()
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
