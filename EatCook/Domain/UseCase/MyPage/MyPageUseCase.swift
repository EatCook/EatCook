//
//  MyPageUseCase.swift
//  EatCook
//
//  Created by 이명진 on 7/21/24.
//

import Foundation
import Combine

final class MyPageUseCase {
    
    private let eatCookRepository: EatCookRepositoryType
    private var cancellabels = Set<AnyCancellable>()
    
    init(eatCookRepository: EatCookRepositoryType) {
        self.eatCookRepository = eatCookRepository
    }
    
}

extension MyPageUseCase {
    
    func responseMyPage(_ page: Int) -> AnyPublisher<MyPageResponse, NetworkError> {
        return eatCookRepository
            .responseMyPage(of: MyPageAPI.mypage(page))
            .eraseToAnyPublisher()
    }
    
    func responseMyPageArchive() -> AnyPublisher<MyPageArchiveResponse, NetworkError> {
        return eatCookRepository
            .responseMyPageArchive(of: MyPageAPI.mypageArchive)
            .eraseToAnyPublisher()
    }
    
}
