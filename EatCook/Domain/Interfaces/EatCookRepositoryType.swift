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
    
}
