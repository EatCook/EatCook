//
//  EatCookRepositoryType.swift
//  EatCook
//
//  Created by 이명진 on 2/26/24.
//

import Foundation
import Combine

protocol EatCookRepositoryType: AnyObject {
    /// CookTalk
    func responseCookTalkFeed(of endpoint: EndPoint) -> Future<CookTalkFeedResponse, NetworkError>
    func responseCookTalkFollow(of endpoint: EndPoint) -> Future<CookTalkFollowResponse, NetworkError>
    
    /// Recipe
    func responseRecipeRead(of endpoint: EndPoint) -> Future<RecipeReadResponse, NetworkError>
    func requestRecipeCreate(of endpoint: EndPoint) -> Future<RecipeCreateResponse, NetworkError>
    func requestRecipeDelete(of endpoint: EndPoint) -> Future<RecipeDeleteRequestResponse, NetworkError>
    
    /// Liked
    func requestLikeAddOrDelete(of endpoint: EndPoint) -> Future<LikedCheckRequestResponse, NetworkError>
    
    /// Follow
    func requestFollowOrUnFollow(of endpoint: EndPoint) -> Future<EmptyResponse, NetworkError>
    
    /// MyPage
    func responseMyPageUserInfo(of endpoint: EndPoint) -> Future<MyPageResponse, NetworkError>
    func requestMyPageProfileEdit(of endpoint: EndPoint) -> Future<MyPageProfileEditRequestResponse, NetworkError>
    func requestMyPageProfileImageEdit(of endpoint: EndPoint) -> Future<MyPageProfileImageEditResponse, NetworkError>
    func responseMyPageMyRecipe(of endpoint: EndPoint) -> Future<MyPageMyRecipeResponse, NetworkError>
    func responseMyPageArchive(of endpoint: EndPoint) -> Future<MyPageArchiveResponse, NetworkError>
    
    /// MyPageSetting
    func responseMyFavoriteTag(of endpoint: EndPoint) -> Future<MyFavoriteCookResponse, NetworkError>
    func requestMyFavoriteTagUpdate(of endpoint: EndPoint) -> Future<MyFavoriteTagRequestResponse, NetworkError>
    func requestUserWithDraw(of endpoint: EndPoint) -> Future<UserWithDrawResponse, NetworkError>
    
    /// OtherUser
    func responseOtherUserInfo(of endpoint: EndPoint) -> Future<OtherUserInfoResponse, NetworkError>
    func responseOtherUserPosts(of endpoint: EndPoint) -> Future<OtherUserPostsResponse, NetworkError>
    
    /// Archive
    func requestArchiveAdd(of endpoint: EndPoint) -> Future<ArchiveAddRequestResponse, NetworkError>
    
    
    // Login
    func login(of endpoint: EndPoint) -> Future<LoginResponse, NetworkError>
    func socialLogin(of endpoint: EndPoint) -> Future<SocialLoginResponse , NetworkError>
    
    //Home
    func userInfo(of endpoint: EndPoint) -> Future<MainUserInfoResponse, NetworkError>
    func cookingTheme(of endpoint: EndPoint) -> Future<MainUserInfoInterestResponse, NetworkError>
    func lifeType(of endpoint: EndPoint) -> Future<MainUserLifeTypeResponse, NetworkError>
    
    //Auth
    func requestEmail(of endpoint: EndPoint) -> Future<EmailRequestResponse, NetworkError>
    func emailVerify(of endpoint: EndPoint) -> Future<EmailVerifyResponse, NetworkError>
    func signUp(of endpoint: EndPoint) -> Future<SignUpResponse, NetworkError>
    func checkNickName(of endpoint: EndPoint) -> Future<CheckNickNameResponse, NetworkError>
    func addSignUp(of endpoint: EndPoint) -> Future<AddSignUpResponse, NetworkError>
    func findPasswordRequestEmail(of endpoint: EndPoint) -> Future<FindAccountResponse, NetworkError>
    func findPasswordEmailVerify(of endpoint: EndPoint) -> Future<FindAccountVerifyResponse, NetworkError>
    func setNewPassword(of endpoint: EndPoint) -> Future<FindNewPasswordResponse, NetworkError>
}
