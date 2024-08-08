//
//  HomeUseCase.swift
//  EatCook
//
//  Created by 강신규 on 8/8/24.
//

import Foundation
import Combine


final class HomeUseCase {
    
    private let eatCookRepository: EatCookRepositoryType
    private var cancellabels = Set<AnyCancellable>()
    
    init(eatCookRepository: EatCookRepositoryType) {
        self.eatCookRepository = eatCookRepository
    }
    
    
    
}

extension HomeUseCase {
    
    func userInfo() -> AnyPublisher<MainUserInfoResponse, NetworkError> {
        return eatCookRepository
            .userInfo(of: HomeAPI.userInfo)
            .eraseToAnyPublisher()
    }
    
    
    func cookingTheme(_ cookingTheme : String) -> AnyPublisher<MainUserInfoInterestResponse, NetworkError> {
        return eatCookRepository
            .cookingTheme(of: HomeAPI.cookingTheme(cookingTheme))
            .eraseToAnyPublisher()
    }
    

    
    func lifeType(_ lifeType : String) -> AnyPublisher<MainUserLifeTypeResponse, NetworkError> {
        return eatCookRepository
            .lifeType(of: HomeAPI.lifeType(lifeType))
            .eraseToAnyPublisher()
    }
    
}
