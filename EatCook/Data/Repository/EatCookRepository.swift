//
//  EatCookRepository.swift
//  EatCook
//
//  Created by 이명진 on 2/7/24.
//

import Foundation

final class EatCookRepository: EatCookRepositoryType {
    
    private let networkProvider: NetworkProvider
    
    init(
        networkProvider: NetworkProvider
    ) {
        self.networkProvider = networkProvider
    }
}

extension EatCookRepository {
    
    func fetchLoginInfo(of endpoint: EndPoint) async throws -> Result<LoginResponse, NetworkError> {
        let response = try await networkProvider.excute(LoginResponseDTO.self, of: endpoint)
        switch response {
        case .success(let data):
            return .success(data.toDomain())
        case .failure(let error):
            return .failure(error)
        }
    }
}
