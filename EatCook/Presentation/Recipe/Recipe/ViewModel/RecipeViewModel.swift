//
//  RecipeViewModel.swift
//  EatCook
//
//  Created by 이명진 on 2/8/24.
//

import Foundation
import Combine

final class RecipeViewModel: ObservableObject {
    
    private let recipeUseCase: RecipeUseCase
    let loginUserInfo: LoginUserInfoManager
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var recipeReadData: RecipeReadResponseData?
    @Published var recipeProcessData: [RecipeData] = []
    @Published var postId: Int = 0
    @Published var isLoading: Bool = false
    @Published var error: String? = nil
    
    @Published var userId: Int = 0
    @Published var isFollowed: Bool = false
    @Published var isLiked: Bool = false
    @Published var isArchived: Bool = false
    
    @Published var isMyRecipe: Bool = false
    
    @Published var isDeletedLoading: Bool = false
    @Published var isDeletedError: String? = nil
    
    init(
        recipeUseCase: RecipeUseCase,
        loginUserInfo: LoginUserInfoManager
    ) {
        self.recipeUseCase = recipeUseCase
        self.loginUserInfo = loginUserInfo
    }
    
    private func setupBinding() {
        $userId
            .combineLatest(loginUserInfo.$userInfo)
            .map { userId, userInfo in
                return userId == userInfo.userId
            }
            .sink { [weak self] value in
                guard let self = self else { return }
                self.isMyRecipe = value
            }
            .store(in: &cancellables)
        
    }
    
}

extension RecipeViewModel {
    func responseRecipeRead(_ recipeId: Int) {
        isLoading = true
        error = nil
        
        recipeUseCase.responseRecipeRead(recipeId)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("RecipeRead Finished")
                    self.isLoading = false
                case .failure(let error):
                    self.isLoading = false
                    self.error = error.localizedDescription
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                self.recipeReadData = response.data
                self.userId = response.data.writerUserId
                self.isFollowed = response.data.followCheck
                self.isArchived = response.data.archiveCheck
                self.isLiked = response.data.likedCheck
                self.postId = response.data.postId
                
                let recipe = response.data.recipeProcess.map { RecipeData(type: .recipe,
                                                                          image: $0.recipeProcessImagePath,
                                                                          step: $0.stepNum,
                                                                          description: $0.recipeWriting)}
                let ingredients = response.data.foodIngredients.map { RecipeData(type: .ingredients,
                                                                                 description: $0) }
                self.recipeProcessData.append(contentsOf: recipe)
                self.recipeProcessData.append(contentsOf: ingredients)
                self.setupBinding()
            }
            .store(in: &cancellables)

    }
    
    func requestDeleteRecipe(_ postId: Int) async {
        isDeletedLoading = true
        isDeletedError = nil
        
        return await withCheckedContinuation { continuation in
            recipeUseCase.requestRecipeDelete(postId)
    //            .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("삭제 완료!!!!!!!!")
                        self.isDeletedLoading = false
                        self.isDeletedError = nil
                        continuation.resume()
                    case .failure(let error):
                        print(error.localizedDescription)
                        self.isDeletedLoading = false
                        self.isDeletedError = error.localizedDescription
                        continuation.resume()
                    }
                } receiveValue: { response in
                    print(response)
                }
                .store(in: &cancellables)
        }
    }
    
    func requestArchiveAddOrDelete(_ postId: Int) {
        
        recipeUseCase.requestArchiveAdd(postId, isArchived)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("추가 완료")
                    self.isArchived.toggle()
                case .failure(let error):
                    print("추가 실패 \(error.localizedDescription)")
                }
            } receiveValue: { response in
                print(response.data)
            }
            .store(in: &cancellables)

    }
    
    func requestLikedAddOrDelete(_ postId: Int) {
        
        recipeUseCase.requestLikeAddOrDelete(postId, isLiked)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("좋아요!!!!!!!!!! toggle")
                    self.isLiked.toggle()
                case .failure(let error):
                    print("좋아요 에러 \(error.localizedDescription)")
                }
            } receiveValue: { response in
                print(response)
            }
            .store(in: &cancellables)

    }
    
    func requestFollowOrUnFollow() {
        
        recipeUseCase.requestFollowOrUnFollow(userId, isFollowed)
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
