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
    
}
