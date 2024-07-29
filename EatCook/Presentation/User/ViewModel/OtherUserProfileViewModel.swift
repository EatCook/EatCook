//
//  OtherUserProfileViewModel.swift
//  EatCook
//
//  Created by 이명진 on 7/28/24.
//

import Foundation
import Combine

final class OtherUserProfileViewModel: ObservableObject {
    
    private let otherUserUseCase: OtherUserUseCase
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var otherUserInfo = OtherUserInfoResponseData()
    @Published var otherUserPosts: [OtherUserPostsResponseList] = []
    
    @Published var isFollowed: Bool = false
    @Published var userId: Int = 0
    @Published var page: Int = 0
    @Published var isLoading: Bool = false
    @Published var error: String? = nil
    
    init(otherUserUseCase: OtherUserUseCase) {
        self.otherUserUseCase = otherUserUseCase
    }
    
    
}

extension OtherUserProfileViewModel {
    
    func responseOtherUserInfo(_ userId: Int) async {
        isLoading = true
        error = nil
        
        return await withCheckedContinuation { continuation in
            otherUserUseCase.responseOtherUserInfo(userId)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("다른 사용자 정보 받기 완료!!!!!!!")
                        continuation.resume()
                    case .failure(let error):
                        print(error.localizedDescription)
                        self.error = error.localizedDescription
                        continuation.resume()
                    }
                } receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    self.otherUserInfo = response.data
                    self.isFollowed = response.data.followCheck
                    self.userId = response.data.userId
                }
                .store(in: &cancellables)

        }
    }
    
    func responseOtherUserPosts(_ userId: Int, _ page: Int) async {
        isLoading = true
        error = nil
        
        return await withCheckedContinuation { continuation in
            otherUserUseCase.responseOtherUserPosts(userId, page)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("다른 사용자 게시물 받기 완료!!!!!")
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
                    self.otherUserPosts = response.data.content
                }
                .store(in: &cancellables)

        }
    }
    
    func requestFollowOrUnFollow() {
        
        otherUserUseCase.requestFollowOrUnFollow(userId, isFollowed)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("팔로우 언팔로우 완료!!!!!!!!")
                    self.isFollowed.toggle()
                case .failure(let error):
                    print("팔로우 언팔로우 에러!!! \(error.localizedDescription)")
                }
            } receiveValue: { response in
                
            }
            .store(in: &cancellables)

    }
}
