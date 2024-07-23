//
//  UserProfileEditViewModel.swift
//  EatCook
//
//  Created by 이명진 on 7/23/24.
//

import Foundation
import Combine

final class UserProfileEditViewModel: ObservableObject {
    
    private let myPageUseCase: MyPageUseCase
    private let loginUserInfo: LoginUserInfoManager
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var userNickName: String = ""
    @Published var userEmail: String = ""
    @Published var userProfileImagePath: String = ""
    
    @Published var isLoading: Bool = false
    @Published var error: String? = nil
    
    init(
        myPageUseCase: MyPageUseCase,
        loginUserInfo: LoginUserInfoManager
    ) {
        self.myPageUseCase = myPageUseCase
        self.loginUserInfo = loginUserInfo
        setupProfile()
    }
    
    private func setupProfile() {
        let userInfo = UserInfo(
            email: "itcook1@gmail.com",
            nickName: "닉네임이다.",
            profileImagePath: "https://pds.joongang.co.kr/news/component/joongang_sunday/202301/28/6ec1d8f0-6fa4-47b6-b527-8f299c25c6ee.jpg"
        )
        loginUserInfo.userInfo = userInfo
        
        if let info = loginUserInfo.userInfo {
            self.userNickName = info.nickName
            self.userEmail = info.email
            self.userProfileImagePath = info.profileImagePath ?? ""
        }
    }
    
}

extension UserProfileEditViewModel {
    func requestUserProfileEdit(_ nickName: String) async {
        isLoading = true
        error = nil
        
        return await withCheckedContinuation { continuation in
            myPageUseCase.requestMyPageProfileEdit(nickName)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("Edit Success!!!")
                        self.isLoading = false
                        continuation.resume()
                    case .failure(let error):
                        print(error.localizedDescription)
                        self.isLoading = false
                        self.error = error.localizedDescription
                        continuation.resume()
                    }
                } receiveValue: { response in
                    print(response.data)
                }
                .store(in: &cancellables)
        }

    }
    
}
