//
//  RecipeUseCase.swift
//  EatCook
//
//  Created by 이명진 on 7/16/24.
//

import Foundation
import Combine

final class RecipeUseCase {
    
    private let eatCookRepository: EatCookRepositoryType
    private var cancellables = Set<AnyCancellable>()
    
    init(eatCookRepository: EatCookRepositoryType) {
        self.eatCookRepository = eatCookRepository
    }
    
}

extension RecipeUseCase {
    
    func responseRecipeRead(_ postId: Int) -> AnyPublisher<RecipeReadResponse, NetworkError> {
        return eatCookRepository
            .responseRecipeRead(of: RecipeAPI.recipeRead(postId))
            .eraseToAnyPublisher()
    }
    
    func requestRecipeCreate(_ query: RecipeCreateRequestDTO) -> AnyPublisher<RecipeCreateResponse, NetworkError> {
        return eatCookRepository
            .requestRecipeCreate(of: RecipeAPI.recipeCreate(query))
            .eraseToAnyPublisher()
    }
    
    func requestRecipeDelete(_ postId: Int) -> AnyPublisher<RecipeDeleteRequestResponse, NetworkError> {
        return eatCookRepository
            .requestRecipeDelete(of: RecipeAPI.recipeDelete(postId))
            .eraseToAnyPublisher()
    }
    
    func requestArchiveAdd(_ postId: Int, _ isArchived: Bool) -> AnyPublisher<ArchiveAddRequestResponse, NetworkError> {
        let endPoint: EndPoint = isArchived ? ArchiveAPI.archiveDelete(postId) : ArchiveAPI.archiveAdd(postId)
        return eatCookRepository
            .requestArchiveAdd(of: endPoint)
            .eraseToAnyPublisher()
    }
    
    func requestLikeAddOrDelete(_ postId: Int, _ isLiked: Bool) -> AnyPublisher<LikedCheckRequestResponse, NetworkError> {
        let endPoint: EndPoint = isLiked ? LikeCheckAPI.likeDelete(postId) : LikeCheckAPI.likeAdd(postId)
        return eatCookRepository
            .requestLikeAddOrDelete(of: endPoint)
            .eraseToAnyPublisher()
    }
    
    func requestFollowOrUnFollow(_ toUserId: Int, _ isFollowed: Bool) -> AnyPublisher<EmptyResponse, NetworkError> {
        let endPoint: EndPoint = isFollowed ? FollowAPI.unfollow(toUserId) : FollowAPI.follow(toUserId)
        return eatCookRepository
            .requestFollowOrUnFollow(of: endPoint)
            .eraseToAnyPublisher()
    }
    
}
