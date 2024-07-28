//
//  OtherUserUseCase.swift
//  EatCook
//
//  Created by 이명진 on 7/28/24.
//

import Foundation
import Combine

final class OtherUserUseCase {
    
    private let eatCookRepository: EatCookRepositoryType
    private var cancellables = Set<AnyCancellable>()
    
    init(eatCookRepository: EatCookRepositoryType) {
        self.eatCookRepository = eatCookRepository
    }
    
}

extension OtherUserUseCase {
    
    func responseOtherUserInfo(_ userId: Int) -> AnyPublisher<OtherUserInfoResponse, NetworkError> {
        return eatCookRepository
            .responseOtherUserInfo(of: OtherUserAPI.otherUserInfo(userId))
            .eraseToAnyPublisher()
    }
    
    func responseOtherUserPosts(
        _ userId: Int,
        _ page: Int
    ) -> AnyPublisher<OtherUserPostsResponse, NetworkError> {
        return eatCookRepository
            .responseOtherUserPosts(of: OtherUserAPI.otherUserPosts(userId, page))
            .eraseToAnyPublisher()
    }
    
    func requestFollowOrUnFollow(_ toUserId: Int, _ isFollowed: Bool) -> AnyPublisher<EmptyResponse, NetworkError> {
        let endPoint: EndPoint = isFollowed ? FollowAPI.unfollow(toUserId) : FollowAPI.follow(toUserId)
        return eatCookRepository
            .requestFollowOrUnFollow(of: endPoint)
            .eraseToAnyPublisher()
    }
    
}
