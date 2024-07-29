//
//  ArchiveUseCase.swift
//  EatCook
//
//  Created by 이명진 on 7/21/24.
//

import Foundation
import Combine

final class ArchiveUseCase {
    
    private let eatCookRepository: EatCookRepositoryType
    private var cancellabels = Set<AnyCancellable>()
    
    init(eatCookRepository: EatCookRepositoryType) {
        self.eatCookRepository = eatCookRepository
    }
    
    
}

extension ArchiveUseCase {
    
    func requestArchiveAdd(_ postId: Int) -> AnyPublisher<ArchiveAddRequestResponse, NetworkError> {
        return eatCookRepository
            .requestArchiveAdd(of: ArchiveAPI.archiveAdd(postId))
            .eraseToAnyPublisher()
    }
    
}
