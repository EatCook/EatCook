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
    case otherUserProfile(_ userId: Int)
    case login
    case emailLogin
    case search
    case emailAuth
    case passwordCheck(_ email : String)
    case createProfile(_ email : String)
    case foodTheme(_ email : String, _ nickName : String, _ userImage : UIImage)
    case householdComposition(_ email : String, _ nickName : String , cookingType : [String], userImage : UIImage)
    case findAccount
    case changePassword(_ email : String)
    
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
        case .otherUserProfile(let userId): OtherUserProfileView(userId: userId).toolbarRole(.editor)
            
        case .login : LoginView().toolbarRole(.editor).navigationBarHidden(true)
        
        case .emailLogin : EmailLoginView().toolbarRole(.editor)
            
        case .search : SearchView().toolbarRole(.editor)
            
        case .emailAuth : EmailAuthView().toolbarRole(.editor)
            
        case .passwordCheck(let email) : PasswordCheckView(email : email).toolbarRole(.editor)
            
        case .createProfile(let email) : CreateProfileView(email: email).toolbarRole(.editor)
        
        case .foodTheme(let email, let nickName, let userImage) : FoodThemeView(email : email, nickName : nickName, userImage : userImage).toolbarRole(.editor)
            
        case .householdComposition(let email, let nickName, let cookingType, let userImage) : HouseholdCompositionView(email : email, nickName : nickName, cookingType : cookingType  ,userImage : userImage).toolbarRole(.editor)
         
        case .findAccount : FindAccountView().toolbarRole(.editor)
            
        case .changePassword(let email) : ChangePasswordView(email : email).toolbarRole(.editor)
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
        case (.login , .login):
            return true
        case (.emailLogin , .emailLogin):
            return true
        case (.search , .search):
            return true
            
        case (.emailAuth , .emailAuth):
            return true
            
        case (.createProfile , .createProfile) :
            return true
            
        case (.foodTheme , .foodTheme) :
            return true
        
        case (.householdComposition, .householdComposition):
            return true
            
        case (.findAccount , .findAccount):
            return true
            
        case (.changePassword , .changePassword):
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
        case .login:
            hasher.combine("login")
        case .emailLogin:
            hasher.combine("emailLogin")
        case .search:
            hasher.combine("search")
            
        case .emailAuth:
            hasher.combine("emailAuth")
            
        case .passwordCheck(let email):
            hasher.combine("passwordCheck")
            hasher.combine(email)
            
        case .createProfile(let email):
            hasher.combine("createProfile")
            hasher.combine(email)
            
        case .foodTheme(let email, let nickName, let userImage):
            hasher.combine("foodTheme")
            hasher.combine(email)
            hasher.combine(nickName)
            hasher.combine(userImage)
            
        case .householdComposition(let email, let nickName, let cookingType, let userImage):
            hasher.combine("householdComposition")
            hasher.combine(email)
            hasher.combine(nickName)
            hasher.combine(cookingType)
            hasher.combine(userImage)
            
        case .findAccount:
            hasher.combine("findAccount")
            
        case .changePassword(let email):
            hasher.combine("changePassword")
            hasher.combine(email)
        

        }
        

        
    }
}

final class NavigationPathFinder: ObservableObject {
    @Published var path: NavigationPath = .init()
    
    static let shared = NavigationPathFinder()
    private init() { }
    
    func addPath(_ option: ViewOptions) {
        DispatchQueue.main.async {
            self.path.append(option)
        }
    }
    
    func pop() {
        DispatchQueue.main.async {
            guard !self.path.isEmpty else { return }
            self.path.removeLast()
        }
    }
    
    func popToRoot() {
        DispatchQueue.main.async {
            self.path = .init()
        }
    }
}
