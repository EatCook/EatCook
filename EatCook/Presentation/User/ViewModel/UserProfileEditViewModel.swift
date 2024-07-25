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
    @Published var userProfileImagePath: String?
    
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
        if let info = loginUserInfo.userInfo {
            self.userNickName = info.nickName
            self.userEmail = info.email
            self.userProfileImagePath = info.profileImagePath
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
    
    func requestUserProfileImageEdit(_ fileExtention: String) {
        
        
        myPageUseCase.requestMyPageProfileImageEdit(fileExtention)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("이미지 업데이트 성공")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                print(response.data.presignedUrl)
            }
            .store(in: &cancellables)

    }
    
}
