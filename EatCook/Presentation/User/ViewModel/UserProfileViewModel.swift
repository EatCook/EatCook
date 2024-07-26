//
//  UserProfileViewModel.swift
//  EatCook
//
//  Created by 이명진 on 2/8/24.
//

import Foundation
import Combine

final class UserProfileViewModel: ObservableObject {
    
    private let myPageUseCase: MyPageUseCase
    private let loginUserInfo: LoginUserInfoManager
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var myPageUserInfo = MyPageDataResponse()
    @Published var myPageMyRecipeData: [MyPageMyRecipeContent] = []
    @Published var hasNextPage: Bool = false
    
    @Published var myPageArchiveData: [MyPageArchiveData] = []
    
    init(
        myPageUseCase: MyPageUseCase,
        loginUserInfo: LoginUserInfoManager
    ) {
        self.myPageUseCase = myPageUseCase
        self.loginUserInfo = loginUserInfo
    }
    
    private func setupProfile() {
        let userInfo = UserInfo(
            userId: myPageUserInfo.userId,
            email: myPageUserInfo.email,
            nickName: myPageUserInfo.nickName,
            badge: myPageUserInfo.badge,
            followerCounts: myPageUserInfo.followerCounts,
            followingCounts: myPageUserInfo.followingCounts,
            providerType: myPageUserInfo.providerType,
            profileImagePath: myPageUserInfo.userImagePath
        )
        
        loginUserInfo.userInfo = userInfo
    }
    
}

extension UserProfileViewModel {
    func responseMyPage() {
        
        myPageUseCase.responseMyPage()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("마이페이지 응답 완료")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                self.myPageUserInfo = response.data
                self.setupProfile()
            }
            .store(in: &cancellables)
    }
    
    func responseMyPageMyRecipe() {
        
        myPageUseCase.responseMyPageMyRecipe(nil)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("레시피 응답 완료")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                self.myPageMyRecipeData = response.data.content
                self.hasNextPage = response.data.hasNextPage
            }
            .store(in: &cancellables)

    }
    
    func responseMyPageArchives() {
        
        myPageUseCase.responseMyPageArchive()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("보관함 응답 완료")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                self.myPageArchiveData = response.data
            }
            .store(in: &cancellables)

    }
    
}
