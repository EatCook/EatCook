//
//  UserProfileEditViewModel.swift
//  EatCook
//
//  Created by 이명진 on 7/23/24.
//

import SwiftUI
import Combine

final class UserProfileEditViewModel: ObservableObject {
    
    private let myPageUseCase: MyPageUseCase
    private let loginUserInfo: LoginUserInfoManager
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var userProfileImageUpdateResponse = MyPageProfileImageEditResponseData()
    
    @Published var userNickName: String = ""
    @Published var userEmail: String = ""
    @Published var userProfileImagePath: String?
    @Published var userProfileImageExtension: String?
    @Published var userProfileImage: UIImage?
    @Published var userProfileImageURL: URL?
    
    @Published var isLoading: Bool = false
    @Published var error: String? = nil
    @Published var isUpLoadingError: String = ""
    
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
    func requestUserProfileEdit() async {
        guard let info = loginUserInfo.userInfo else { return }
        if info.nickName == self.userNickName { return }
        isLoading = true
        error = nil
        
        return await withCheckedContinuation { continuation in
            myPageUseCase.requestMyPageProfileEdit(userNickName)
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
                } receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    print(response.data)
                    loginUserInfo.userInfo?.nickName = self.userNickName
                }
                .store(in: &cancellables)
        }
        
    }
    
    func requestUserProfileImageEdit() async {
        guard userProfileImage != nil else { return }
//        guard let info = loginUserInfo.userInfo else { return }
//        if info.profileImagePath == self.userProfileImageURL { return }
        guard let fileExtension = userProfileImageExtension else { return }
        isLoading = true
        error = nil
        
        return await withCheckedContinuation { continuation in
            myPageUseCase.requestMyPageProfileImageEdit(fileExtension)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("Profile ImageUpdate PresignedURL Response Success")
                        continuation.resume()
                    case .failure(let error):
                        print(error.localizedDescription)
                        self.isLoading = false
                        self.error = error.localizedDescription
                        continuation.resume()
                    }
                } receiveValue: { response in
                    print(response.data.presignedUrl)
                    self.userProfileImageUpdateResponse = response.data
                }
                .store(in: &cancellables)
        }
    }
    
    func uploadImage() async {
        guard userProfileImage != nil else { return }
//        guard let info = loginUserInfo.userInfo else { return }
//        if info.profileImagePath == self.userProfileImagePath { return }
        
        do {
            try await self.uploadImages(userProfileImageUpdateResponse)
        } catch {
            self.isUpLoadingError = error.localizedDescription
        }
    }
    
    private func uploadImages(_ responseData: MyPageProfileImageEditResponseData) async throws {
        do {
            guard let mainImageURL = userProfileImageURL,
                  let url = URL(string: responseData.presignedUrl) else { throw UploadError.invalidURL }
            
            let (data, response) = try await URLSession.shared.upload(to: url,
                                                                      fileURL: mainImageURL)
            
            print("프로필 이미지 Upload Response: \(response), \(data)")
            self.isLoading = false
        } catch {
            self.isLoading = false
            self.error = error.localizedDescription
            throw UploadError.fileExtension
        }
    }
    
}
