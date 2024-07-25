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
    
    func responseMyPage() -> AnyPublisher<MyPageResponse, NetworkError> {
        return eatCookRepository
            .responseMyPageUserInfo(of: MyPageAPI.mypageUserInfo)
            .eraseToAnyPublisher()
    }
    
    func requestMyPageProfileEdit(_ nickName: String) -> AnyPublisher<MyPageProfileEditRequestResponse, NetworkError> {
        return eatCookRepository
            .requestMyPageProfileEdit(of: MyPageAPI.mypageProfileEdit(nickName))
            .eraseToAnyPublisher()
    }
    
    func requestMyPageProfileImageEdit(_ fileExtention: String) -> AnyPublisher<MyPageProfileImageEditResponse, NetworkError> {
        return eatCookRepository
            .requestMyPageProfileImageEdit(of: MyPageAPI.mypageProfileImageEdit(fileExtention))
            .eraseToAnyPublisher()
    }
    
    func responseMyPageMyRecipe(_ page: Int?) ->AnyPublisher<MyPageMyRecipeResponse, NetworkError> {
        return eatCookRepository
            .responseMyPageMyRecipe(of: MyPageAPI.mypageMyRecipe(page))
            .eraseToAnyPublisher()
    }
    
    func responseMyPageArchive() -> AnyPublisher<MyPageArchiveResponse, NetworkError> {
        return eatCookRepository
            .responseMyPageArchive(of: MyPageAPI.mypageArchive)
            .eraseToAnyPublisher()
    }
    
    
    
}
