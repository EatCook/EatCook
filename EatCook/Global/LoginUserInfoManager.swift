//
//  LoginUserInfoManager.swift
//  EatCook
//
//  Created by 이명진 on 7/23/24.
//

import Foundation
import Combine

final class LoginUserInfoManager: ObservableObject {
    
    static let shared = LoginUserInfoManager(
        eatCookRepository: EatCookRepository(
            networkProvider: NetworkProviderImpl(
                requestManager: NetworkManager())))
    
    private let eatCookRepository: EatCookRepositoryType
    private var cancellables = Set<AnyCancellable>()
    
    @Published var userInfoData = MyPageDataResponse()
    @Published var userInfo = UserInfo()
    
    private init(eatCookRepository: EatCookRepositoryType) {
        self.eatCookRepository = eatCookRepository
        responseUserInfo{  _ in }
    }
    
    func responseUserInfo(completion: @escaping (UserInfo) -> Void) {
        
        self.eatCookRepository
            .responseMyPageUserInfo(of: MyPageAPI.mypageUserInfo)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("로그인 유저 정보 세팅")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                print(response.data)
                self.userInfoData = response.data
                self.setupUserInfo()
                completion(self.userInfo)
            }
            .store(in: &cancellables)
    }
    
    private func setupUserInfo() {
        let userInfo = UserInfo(
            userId: userInfoData.userId,
            email: userInfoData.email,
            nickName: userInfoData.nickName ?? "",
            badge: userInfoData.badge,
            followerCounts: userInfoData.followerCounts,
            followingCounts: userInfoData.followingCounts,
            providerType: userInfoData.providerType,
            profileImagePath: userInfoData.userImagePath
        )
        
        self.userInfo = userInfo
    }
    
}


struct UserInfo {
    var userId: Int = 0
    var email: String = ""
    var nickName: String = ""
    var badge: String = ""
    var followerCounts: Int = 0
    var followingCounts: Int = 0
    var providerType: String = ""
    var profileImagePath: String? = nil
}
