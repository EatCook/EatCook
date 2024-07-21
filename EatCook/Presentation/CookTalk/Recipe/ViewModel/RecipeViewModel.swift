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
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var recipeReadData: RecipeReadResponseData?
    @Published var recipeProcessData: [RecipeData] = []
    @Published var postId: Int = 0
    @Published var isLoading: Bool = false
    @Published var error: String? = nil
    
    @Published var isFollowed: Bool = false
    @Published var isArchived: Bool = false
    
    init(
        recipeUseCase: RecipeUseCase
    ) {
        self.recipeUseCase = recipeUseCase
    }
    
    
}

extension RecipeViewModel {
    func responseRecipeRead(_ postId: Int) {
        isLoading = true
        error = nil
        
        recipeUseCase.responseRecipeRead(postId)
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
            } receiveValue: { response in
                self.recipeReadData = response.data
                self.isFollowed = response.data.followCheck
                self.isArchived = response.data.archiveCheck
                self.postId = response.data.postID
                let recipe = response.data.recipeProcess.map { RecipeData(type: .recipe,
                                                                          image: $0.recipeProcessImagePath,
                                                                          step: $0.stepNum,
                                                                          description: $0.recipeWriting)}
                let ingredients = response.data.foodIngredients.map { RecipeData(type: .ingredients,
                                                                                 description: $0) }
                self.recipeProcessData.append(contentsOf: recipe)
                self.recipeProcessData.append(contentsOf: ingredients)
                
            }
            .store(in: &cancellables)

    }
    
    func requestArchiveAdd(_ postId: Int) {
        
        recipeUseCase.requestArchiveAdd(postId)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("추가 완료")
                    self.isArchived = true
                case .failure(let error):
                    print("추가 실패 \(error.localizedDescription)")
                }
            } receiveValue: { response in
                print(response.data)
            }
            .store(in: &cancellables)

    }
    
}
