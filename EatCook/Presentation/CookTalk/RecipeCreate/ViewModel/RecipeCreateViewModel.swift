//
//  RecipeCreateViewModel.swift
//  EatCook
//
//  Created by 이명진 on 2/26/24.
//

import SwiftUI
import Combine

final class RecipeCreateViewModel: ObservableObject, Equatable, Hashable {
    
    private let cookTalkUseCase: RecipeUseCase
    
    private var cancellables = Set<AnyCancellable>()
    
    /// 첫번째
    @Published var recipeTitle: String = ""
    @Published var recipeDescription: String = ""
    @Published var selectHours: Int = 0
    @Published var selectMinutes: Int = 0
    @Published var selectedTime: Int = 0
    @Published var selectedTheme: String = "테마 선택"
    @Published var titleImage: UIImage?
    @Published var titleImageExtension: String?
    
    /// 두번째
    @Published var ingredientsInputText: String = ""
    @Published var ingredientsTags: [Tag] = []
    
    /// 세번째
    @Published var recipeStepData: [RecipeStep] = []
        
    @Published var recipeCreateData = RecipeCreateRequest()
    
    @Published var isUpLoading: Bool = false
    @Published var isUpLoadingError: String? = nil
    
    init(cookTalkUseCase: RecipeUseCase) {
        self.cookTalkUseCase = cookTalkUseCase
        setupBinding()
    }
    
    private func setupBinding() {
        $recipeTitle
            .sink { [weak self] newValue in
                self?.recipeCreateData.recipeName = newValue
            }
            .store(in: &cancellables)
        
        $recipeDescription
            .sink { [weak self] newValue in
                self?.recipeCreateData.introduction = newValue
            }
            .store(in: &cancellables)
        
        $selectedTime
            .sink { [weak self] newValue in
                self?.recipeCreateData.recipeTime = newValue
            }
            .store(in: &cancellables)
        
        $selectedTheme
            .sink { [weak self] newValue in
                self?.recipeCreateData.cookingType = [newValue]
            }
            .store(in: &cancellables)
        
        $titleImageExtension
            .sink { [weak self] newValue in
                self?.recipeCreateData.mainFileExtension = newValue ?? ""
            }
            .store(in: &cancellables)
        
        $ingredientsTags
            .sink { [weak self] newValue in
                self?.recipeCreateData.foodIngredients = newValue.map { $0.value }
            }
            .store(in: &cancellables)
        
        $recipeStepData
            .sink { [weak self] newValue in
                self?.recipeCreateData.recipeProcess = newValue.enumerated().map { index, data in
                    RecipeProcess(stepNum: index + 1, recipeWriting: data.description, fileExtension: "jpeg")
                }
            }
            .store(in: &cancellables)
    }
    
    func addStep(_ data: RecipeStep) {
        recipeStepData.append(data)
    }
    
    func updateStep(_ index: Int, _ selectedImage: UIImage?) {
        if let image = selectedImage {
            recipeStepData[index].image = image
            recipeStepData[index].isEditing.toggle()
        } else {
            recipeStepData[index].isEditing.toggle()
        }
    }
    
    func deleteStep() {
        
    }
    
    static func == (lhs: RecipeCreateViewModel, rhs: RecipeCreateViewModel) -> Bool {
        return lhs === rhs // 인스턴스가 동일한지 확인
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self)) // 객체의 고유 식별자를 사용하여 해시 생성
    }
}

extension RecipeCreateViewModel {
    func requestRecipeCreate() {
        isUpLoading = true
        isUpLoadingError = nil
        
        let recipeCreateDTO = RecipeCreateRequestDTO(query: recipeCreateData)
        cookTalkUseCase.requestRecipeCreate(recipeCreateDTO)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    self.isUpLoading = false
                case .failure(let error):
                    self.isUpLoading = false
                    self.isUpLoadingError = error.localizedDescription
                }
            } receiveValue: { response in
                print(response.code)
            }
            .store(in: &cancellables)

        
    }
}
