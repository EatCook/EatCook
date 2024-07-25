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
    
    /// MyPage
    func responseMyPageUserInfo(of endpoint: EndPoint) -> Future<MyPageResponse, NetworkError>
    func requestMyPageProfileEdit(of endpoint: EndPoint) -> Future<MyPageProfileEditRequestResponse, NetworkError>
    func requestMyPageProfileImageEdit(of endpoint: EndPoint) -> Future<MyPageProfileImageEditResponse, NetworkError>
    func responseMyPageMyRecipe(of endpoint: EndPoint) -> Future<MyPageMyRecipeResponse, NetworkError>
    func responseMyPageArchive(of endpoint: EndPoint) -> Future<MyPageArchiveResponse, NetworkError>
    
    
    /// Archive
    func requestArchiveAdd(of endpoint: EndPoint) -> Future<ArchiveAddRequestResponse, NetworkError>
}
