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
    
    func requestRecipeCreate(of endpoint: EndPoint) -> Future<RecipeCreateResponse, NetworkError> {
        return Future { promise in
            Task {
                do {
                    let response = try await self.networkProvider.excute(RecipeCreateResponse.self, of: endpoint)
                    switch response {
                    case .success(let data):
                        promise(.success(data))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } catch {
                    promise(.failure(error as! NetworkError))
                }
            }
        }
    }
    
    func requestRecipeDelete(of endpoint: EndPoint) -> Future<RecipeDeleteRequestResponse, NetworkError> {
        return Future { promise in
            Task {
                do {
                    let response = try await self.networkProvider.excute(RecipeDeleteRequestResponse.self, of: endpoint)
                    switch response {
                    case .success(let data):
                        promise(.success(data))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } catch {
                    promise(.failure(error as! NetworkError))
                }
            }
        }
    }
    
    /// Liked
    func requestLikeAddOrDelete(of endpoint: EndPoint) -> Future<LikedCheckRequestResponse, NetworkError> {
        
        return Future { promise in
            Task {
                do {
                    let response = try await self.networkProvider.excute(LikedCheckRequestResponse.self, of: endpoint)
                    switch response {
                    case .success(let data):
                        promise(.success(data))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } catch {
                    promise(.failure(error as! NetworkError))
                }
            }
        }
    }
    
    /// MyPage
    func responseMyPageUserInfo(of endpoint: EndPoint) -> Future<MyPageResponse, NetworkError> {
        return Future { promise in
            Task {
                do {
                    let response = try await self.networkProvider.excute(MyPageResponseDTO.self, of: endpoint)
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
    
    func requestMyPageProfileEdit(of endpoint: EndPoint) -> Future<MyPageProfileEditRequestResponse, NetworkError> {
        return Future { promise in
            Task {
                do {
                    let response = try await self.networkProvider.excute(MyPageProfileEditRequestResponseDTO.self, of: endpoint)
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
    
    func requestMyPageProfileImageEdit(of endpoint: EndPoint) -> Future<MyPageProfileImageEditResponse, NetworkError> {
        return Future { promise in
            Task {
                do {
                    let response = try await self.networkProvider.excute(MyPageProfileImageEditResponseDTO.self, of: endpoint)
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
    
    func responseMyPageMyRecipe(of endpoint: EndPoint) -> Future<MyPageMyRecipeResponse, NetworkError> {
        return Future { promise in
            Task {
                do {
                    let response = try await self.networkProvider.excute(MyPageMyRecipeResponseDTO.self, of: endpoint)
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
    
    func responseMyPageArchive(of endpoint: EndPoint) -> Future<MyPageArchiveResponse, NetworkError> {
        return Future { promise in
            Task {
                do {
                    let response = try await self.networkProvider.excute(MyPageArchiveResponseDTO.self, of: endpoint)
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
    
    
    
    /// Archive
    func requestArchiveAdd(of endpoint: EndPoint) -> Future<ArchiveAddRequestResponse, NetworkError> {
        return Future { promise in
            Task {
                do {
                    let response = try await self.networkProvider.excute(ArchiveAddRequestResponseDTO.self, of: endpoint)
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
