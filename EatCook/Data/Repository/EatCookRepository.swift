//
//  EatCookRepository.swift
//  EatCook
//
//  Created by 이명진 on 2/7/24.
//

import Foundation
import Combine

final class EatCookRepository: EatCookRepositoryType {
    
    private let networkProvider: NetworkProvider
    
    init(
        networkProvider: NetworkProvider
    ) {
        self.networkProvider = networkProvider
    }
}

extension EatCookRepository {
    
    /// CookTalk API
    func responseCookTalkFeed(of endpoint: EndPoint) -> Future<CookTalkFeedResponse, NetworkError> {
        return Future { promise in
            Task {
                do {
                    let response = try await self.networkProvider.excute(CookTalkFeedResponseDTO.self, of: endpoint)
                    switch response {
                    case .success(let data):
                        promise(.success(data.toDomain()))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } catch {
                    promise(.failure(error as! NetworkError))
                }
            }
        }
    }
    
    func responseCookTalkFollow(of endpoint: EndPoint) -> Future<CookTalkFollowResponse, NetworkError> {
        return Future { promise in
            Task {
                do {
                    let response = try await self.networkProvider.excute(CookTalkFollowResponseDTO.self, of: endpoint)
                    switch response {
                    case .success(let data):
                        promise(.success(data.toDomain()))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } catch {
                    promise(.failure(error as! NetworkError))
                }
            }
        }
    }
    
    /// Recipe API
    func responseRecipeRead(of endpoint: EndPoint) -> Future<RecipeReadResponse, NetworkError> {
        return Future { promise in
            Task {
                do {
                    let response = try await self.networkProvider.excute(RecipeReadResponseDTO.self, of: endpoint)
                    switch response {
                    case .success(let data):
                        promise(.success(data.toDomain()))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } catch {
                    promise(.failure(error as! NetworkError))
                }
            }
        }
    }
    
    
    
    
}
