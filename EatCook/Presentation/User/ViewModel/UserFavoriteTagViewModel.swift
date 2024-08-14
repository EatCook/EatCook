//
//  UserFavoriteTagViewModel.swift
//  EatCook
//
//  Created by 이명진 on 7/28/24.
//

import Foundation
import Combine

final class UserFavoriteTagViewModel: ObservableObject {
    
    private let myPageUseCase: MyPageUseCase
    private var cancellables = Set<AnyCancellable>()
    
    @Published var myFavoriteTagData = MyFavoriteCookResponseData()
    
    @Published var foodTag: [FavoriteFoodTag] = []
    @Published var foodThemeTag: [FoodThemeTag] = []
    
    @Published var isUpdate: Bool = false
    @Published var isUpdateError: String? = nil
    
    
    init(
        myPageUseCase: MyPageUseCase
    ) {
        self.myPageUseCase = myPageUseCase
        setupTag()
    }
    
    private func setupBinding() {
        
    }
    
    private func setupTag() {
        foodTag = [
            FavoriteFoodTag(title: "반찬"),
            FavoriteFoodTag(title: "일식"),
            FavoriteFoodTag(title: "중식"),
            FavoriteFoodTag(title: "한식"),
            FavoriteFoodTag(title: "양식"),
            FavoriteFoodTag(title: "디저트"),
            FavoriteFoodTag(title: "아시안"),
            FavoriteFoodTag(title: "야식"),
            FavoriteFoodTag(title: "분식")
        ]
        
        foodThemeTag = [
            FoodThemeTag(title: "다이어트만 n년째"),
            FoodThemeTag(title: "건강한 식단관리"),
            FoodThemeTag(title: "밀키트 lover"),
            FoodThemeTag(title: "편의점은 내 구역"),
            FoodThemeTag(title: "배달음식 단골고객")
        ]
    }
    
    private func selectedTag() -> ([String], String) {
        let selectedFoodTag = self.foodTag.filter { $0.isSelected }
        let selectedFoodTheme = self.foodThemeTag.filter { $0.isSelected }
        
        var selectedFoodTagTitle = selectedFoodTag.map { $0.title }
        var selectedFoodThemeTitle = selectedFoodTheme.isEmpty ? [""] : selectedFoodTheme.map { $0.title }
        
        return (selectedFoodTagTitle, selectedFoodThemeTitle[0])
    }
    
    private func setupSelected() {
        for tag in self.myFavoriteTagData.cookingTypes {
            let index = FoodTagCase(rawValue: tag)?.index
            guard let index = index else { return }
            foodTag[index].isSelected = true
        }
        
        let theme = self.myFavoriteTagData.lifeType
        let index = FoodThemeCase(rawValue: theme)?.index
        guard let index = index else { return }
        foodThemeTag[index].isSelected = true
    }
    
}

extension UserFavoriteTagViewModel {
    func responseMyFavoriteTag() {
        
        myPageUseCase.responseMyFavoriteTag()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("태그 정보 수신 완료!!!")
                case .failure(let error):
                    print("태그 정보 수신 에러 \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.myFavoriteTagData = response.data
                self.setupSelected()
            }
            .store(in: &cancellables)

    }
    
    func requestMyFavoriteTagUpdate() async {
        isUpdate = true
        isUpdateError = nil
        
        var data = selectedTag()
        
        let myFavoriteTagRequestDTO = MyFavoriteTagRequestDTO(
            lifeType: data.1,
            cookingTypes: data.0
        )
        
        return await withCheckedContinuation { continuation in
            myPageUseCase.requestMyFavoriteTagUpdate(myFavoriteTagRequestDTO)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("태그 업데이트 성공")
                        self.isUpdate = false
                        self.isUpdateError = nil
                        continuation.resume()
                    case .failure(let error):
                        print("태그 업데이트 에러 \(error.localizedDescription)")
                        self.isUpdate = false
                        self.isUpdateError = error.localizedDescription
                        continuation.resume()
                    }
                } receiveValue: { response in
                    print("태그 업데이트 response : \(response)")
                }
                .store(in: &cancellables)
        }
    }
}

enum FoodTagCase: String, CaseIterable {
    case sideDish = "반찬"
    case japan = "일식"
    case china = "중식"
    case korea = "한식"
    case western = "양식"
    case dessert = "디저트"
    case asian = "아시안"
    case night = "야식"
    case flourBasedFood = "분식"
    
    var index: Int {
        switch self {
        case .sideDish:
            return 0
        case .japan:
            return 1
        case .china:
            return 2
        case .korea:
            return 3
        case .western:
            return 4
        case .dessert:
            return 5
        case .asian:
            return 6
        case .night:
            return 7
        case .flourBasedFood:
            return 8
        }
    }
}

enum FoodThemeCase: String, CaseIterable {
    case diet = "다이어트만 n년째"
    case healthy = "건강한 식단관리"
    case mealkit = "밀키트 lover"
    case store = "편의점은 내 구역"
    case delivery = "배달음식 단골고객"
    
    var index: Int {
        switch self {
        case .diet:
            return 0
        case .healthy:
            return 1
        case .mealkit:
            return 2
        case .store:
            return 3
        case .delivery:
            return 4
        }
    }
}
