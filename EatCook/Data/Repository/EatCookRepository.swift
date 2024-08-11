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
    
    /// Follow
    func requestFollowOrUnFollow(of endpoint: EndPoint) -> Future<EmptyResponse, NetworkError> {
        return Future { promise in
            Task {
                do {
                    let response = try await self.networkProvider.excute(EmptyResponse.self, of: endpoint)
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
    
    /// MyPageSetting
    func responseMyFavoriteTag(of endpoint: EndPoint) -> Future<MyFavoriteCookResponse, NetworkError> {
        return Future { promise in
            Task {
                do {
                    let response = try await self.networkProvider.excute(MyFavoriteCookResponseDTO.self, of: endpoint)
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
    
    func requestMyFavoriteTagUpdate(of endpoint: EndPoint) -> Future<MyFavoriteTagRequestResponse, NetworkError> {
        return Future { promise in
            Task {
                do {
                    let response = try await self.networkProvider.excute(MyFavoriteTagRequestResponse.self, of: endpoint)
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
    
    /// OtherUser
    func responseOtherUserInfo(of endpoint: EndPoint) -> Future<OtherUserInfoResponse, NetworkError> {
        return Future { promise in
            Task {
                do {
                    let response = try await self.networkProvider.excute(OtherUserInfoResponseDTO.self, of: endpoint)
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
    
    func responseOtherUserPosts(of endpoint: EndPoint) -> Future<OtherUserPostsResponse, NetworkError> {
        return Future { promise in
            Task {
                do {
                    let response = try await self.networkProvider.excute(OtherUserPostsResponseDTO.self, of: endpoint)
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
    
    // Login
    func login(of endpoint: any EndPoint) -> Future<LoginResponse, NetworkError> {
        return Future { promise in
            Task {
                do {
                    let response = try await self.networkProvider.excute(LoginResponseDTO.self, of: endpoint)
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
    
    func socialLogin(of endpoint: any EndPoint) -> Future<SocialLoginResponse, NetworkError> {
        return Future { promise in
            Task {
                do {
                    let response = try await self.networkProvider.excute(SocialLoginResponseDTO.self, of: endpoint)
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
    
    //Home
    func userInfo(of endpoint: any EndPoint) -> Future<MainUserInfoResponse, NetworkError> {
        return Future { promise in
            Task {
                do {
                    let response = try await self.networkProvider.excute(MainUserInfoResponseDTO.self, of: endpoint)
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
    
    func cookingTheme(of endpoint: any EndPoint) -> Future<MainUserInfoInterestResponse, NetworkError> {
        return Future { promise in
            Task {
                do {
                    let response = try await self.networkProvider.excute(MainUserInfoInterestResponseDTO.self, of: endpoint)
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
    
    func lifeType(of endpoint: any EndPoint) -> Future<MainUserLifeTypeResponse, NetworkError> {
        return Future { promise in
            Task {
                do {
                    let response = try await self.networkProvider.excute(MainUserLifeTypeResponseDTO.self, of: endpoint)
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
    
    //    Auth
    func requestEmail(of endpoint: any EndPoint) -> Future<EmailRequestResponse, NetworkError> {
        return Future { promise in
            Task {
                do {
                    let response = try await self.networkProvider.excute(EmailRequestResponseDTO.self, of: endpoint)
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
    
    func emailVerify(of endpoint: any EndPoint) -> Future<EmailVerifyResponse, NetworkError> {
        return Future { promise in
            Task {
                do {
                    let response = try await self.networkProvider.excute(EmailVerifyResponseDTO.self, of: endpoint)
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
    
    func signUp(of endpoint: any EndPoint) -> Future<SignUpResponse, NetworkError> {
        return Future { promise in
            Task {
                do {
                    let response = try await self.networkProvider.excute(SignUpResponseDTO.self, of: endpoint)
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
