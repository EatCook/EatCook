//
//  CookTalkUseCase.swift
//  EatCook
//
//  Created by 이명진 on 7/15/24.
//

import Foundation
import Combine

final class CookTalkUseCase {
    
    private let eatCookRepository: EatCookRepositoryType
    private var cancellables = Set<AnyCancellable>()
    
    init(eatCookRepository: EatCookRepositoryType) {
        self.eatCookRepository = eatCookRepository
    }
    
}

extension CookTalkUseCase {
    
    func responseCookTalkFeed(_ page: Int) -> AnyPublisher<CookTalkFeedResponse, NetworkError> {
        return eatCookRepository
            .responseCookTalkFeed(of: CookTalkAPI.cookTalkFeed(page))
            .eraseToAnyPublisher()
    }
    
    func responseCookTalkFollow(_ page: Int) -> AnyPublisher<CookTalkFollowResponse, NetworkError> {
        return eatCookRepository
            .responseCookTalkFollow(of: CookTalkAPI.cookTalkFollow(page))
            .eraseToAnyPublisher()
    }
}
