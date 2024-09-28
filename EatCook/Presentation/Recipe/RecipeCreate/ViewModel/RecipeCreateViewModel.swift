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
    private var imageLoader = ImageLoadManager()
    
    /// 첫번째
    @Published var recipeTitle: String = ""
    @Published var recipeDescription: String = ""
    @Published var selectHours: Int = 0
    @Published var selectMinutes: Int = 0
    @Published var selectedTime: Int = 0
    @Published var selectedTheme: String = "테마 선택"
    @Published var titleImage: UIImage?
    @Published var titleImageURL: URL?
    @Published var titleImageExtension: String = ""
    @Published var lifeType : String = ""
    
    /// 두번째
    @Published var ingredientsInputText: String = ""
    @Published var ingredientsTags: [Tag] = []
    
    /// 세번째
    @Published var recipeStepData: [RecipeStep] = []
    @Published var recipeStepImage: UIImage?
    @Published var recipeStepImageURL: URL?
    @Published var recipeStepImageExtension: String = ""
    
    @Published var recipeStepUpdateImage: UIImage?
    
    /// 레시피 생성 과정 담긴 모델 -> 요청시 DTO로 변경함.
    @Published var recipeCreateData = RecipeCreateRequest()
    
    @Published var isUpLoading: Bool = false
    @Published var isUpLoadingError: String? = nil
    
    /// Response 모델
    @Published var recipeCreateResponse = ResponseData()
    
    /// 편집 Response 모델
    @Published var recipeReadResponseData = RecipeReadResponseData()
    @Published var isEditType: Bool = false
    @Published var postId: Int = 0
    
    init(
        cookTalkUseCase: RecipeUseCase
    ) {
        self.cookTalkUseCase = cookTalkUseCase
        setupBinding()
    }
    
    private func setupPreviousRecipe() {
        /// 첫번째
        print("recipeReadResponseData" , recipeReadResponseData)
        
        self.recipeTitle = self.recipeReadResponseData.recipeName
        self.recipeDescription = self.recipeReadResponseData.introduction
        if let imageUrl = URL(string: "\(Environment.AwsBaseURL)/\(recipeReadResponseData.postImagePath)") {
            imageLoader.load(url: imageUrl)
            guard let image = imageLoader.image else { return }
            self.titleImage = image
        }
        self.selectedTime = self.recipeReadResponseData.recipeTime
        self.selectedTheme = self.recipeReadResponseData.cookingType.first ?? "테마 선택"
        self.lifeType = self.recipeReadResponseData.lifeTypes.first ?? ""
        self.titleImageExtension = self.recipeReadResponseData.postImagePath

        /// 두번째
        var ingredientsTagArr: [Tag] = []
        for ingredient in recipeReadResponseData.foodIngredients {
            let tag = Tag(value: ingredient)
            ingredientsTagArr.append(tag)
            self.ingredientsTags = ingredientsTagArr
        }
        
        /// 세번째
        var recipeStepArr: [RecipeStep] = []
        for step in recipeReadResponseData.recipeProcess {
            if let imageUrl = URL(string: "\(Environment.AwsBaseURL)/\(step.recipeProcessImagePath)") {
                imageLoader.load(url: imageUrl)
                guard let image = imageLoader.image else { return }
                let step = RecipeStep(description: step.recipeWriting, image: image, imageExtension: step.recipeProcessImagePath)
                recipeStepArr.append(step)
                self.recipeStepData = recipeStepArr
            }
        }
        
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
                let typeValueDic: [String: String] = [
                    "중식": "CHINESE_FOOD",
                    "반찬": "SIDE_DISH",
                    "디저트": "DESSERT",
                    "한식": "KOREAN_FOOD",
                    "분식": "BUNSIK",
                    "양식": "WESTERN_FOOD",
                    "일식": "JAPANESE_FOOD",
                    "야식": "LATE_NIGHT_SNACK",
                    "아시아" : "ASIAN_FOOD"
                ]
                if let type = typeValueDic[newValue] {
                    self?.recipeCreateData.cookingType = [type]
                }else{
                    print("selectedTheme 변환 에러")
                }
            }
            .store(in: &cancellables)
        
        $lifeType
            .sink { [weak self] newValue in
                let typeValueDic : [String : String] = ["다이어트만 n년째" : "DIET" , "건강한 식단관리" : "HEALTH_DIET" , "편의점은 내 구역" : "CONVENIENCE_STORE" , "배달음식 단골고객" : "DELIVERY_FOOD" , "밀키트 lover" : "MEAL_KIT" ]
                if let type = typeValueDic[newValue] {
                    self?.recipeCreateData.lifeType = [type]
                }else{
                    print("lifeType 변환 에러")
                }
               
            }
            .store(in: &cancellables)
        
        $titleImageExtension
            .sink { [weak self] newValue in
                self?.recipeCreateData.mainFileExtension = newValue
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
                    RecipeProcess(stepNum: index + 1, recipeWriting: data.description, fileExtension: data.imageExtension == "" ? "default" : data.imageExtension)
                }
            }
            .store(in: &cancellables)
    }
    
    func addStep(_ data: RecipeStep) {
        recipeStepData.append(data)
        print("recipeStepData ::::" , recipeStepData)
    }
    
    func updateStep(_ index: Int) {
        if let image = recipeStepUpdateImage {
            recipeStepData[index].image = image
            recipeStepData[index].imageURL = recipeStepImageURL
            recipeStepData[index].imageExtension = recipeStepImageExtension
            recipeStepData[index].isUpdate = true
            recipeStepData[index].isEditing.toggle()
        } else {
            recipeStepData[index].isEditing.toggle()
        }
        recipeStepUpdateImage = nil
        recipeStepImageURL = nil
        recipeStepImageExtension = ""
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
    func requestRecipeCreate() async {
        isUpLoading = true
        isUpLoadingError = nil
        
        let recipeCreateDTO = RecipeCreateRequestDTO(
            recipeName: recipeCreateData.recipeName,
            recipeTime: recipeCreateData.recipeTime,
            introduction: recipeCreateData.introduction,
            mainFileExtension: recipeCreateData.mainFileExtension,
            foodIngredients: recipeCreateData.foodIngredients,
            cookingType: recipeCreateData.cookingType,
            lifeType: recipeCreateData.lifeType,
            recipeProcess: recipeCreateData.recipeProcess.map { $0.toData() }
        )
        
      
        
        return await withCheckedContinuation { continuation in
            cookTalkUseCase.requestRecipeCreate(recipeCreateDTO)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        continuation.resume()
                    case .failure(let error):
                        self.isUpLoading = false
                        self.isUpLoadingError = error.localizedDescription
                        continuation.resume()
                    }
                } receiveValue: { response in
                    print(response.code)
                    self.recipeCreateResponse = response.data
                }
                .store(in: &cancellables)
        }
        
    }
    
    func requestRecipeUpdate(_ recipeId: Int) async {
        isUpLoading = true
        isUpLoadingError = nil
        
        let recipeUpdateDTO = RecipeUpdateRequestDTO(
            recipeName: recipeCreateData.recipeName,
            recipeTime: recipeCreateData.recipeTime,
            introduction: recipeCreateData.introduction,
            mainFileExtension: recipeCreateData.mainFileExtension == "" ? ""  : recipeCreateData.mainFileExtension,
            foodIngredients: recipeCreateData.foodIngredients,
            cookingType: recipeCreateData.cookingType,
            lifeType : recipeCreateData.lifeType,
            recipeProcess: recipeCreateData.recipeProcess.map { $0.toData() }
        )

        
        return await withCheckedContinuation { continuation in
            cookTalkUseCase.requestRecipeUpdate(recipeUpdateDTO, recipeId)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        continuation.resume()
                    case .failure(let error):
                        self.isUpLoading = false
                        self.isUpLoadingError = error.localizedDescription
                        continuation.resume()
                    }
                } receiveValue: { response in
                    print(response.data)
                    self.recipeCreateResponse = response.data
                }
                .store(in: &cancellables)
        }
    }
    
    func responseRecipeRead(_ postId: Int) {
        self.isEditType = true
        self.postId = postId
        
        cookTalkUseCase.responseRecipeRead(postId)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("✅")
                case .failure(let error):
                    print("\(error.localizedDescription)")
                }
            } receiveValue: { response in
                print(response.data)
                self.recipeReadResponseData = response.data
                self.setupPreviousRecipe()
            }
            .store(in: &cancellables)

    }
    
    func uploadImage() async {
        do {
            print("UPLOAD recipeCreateResponse", recipeCreateResponse)
            try await self.uploadImages(recipeCreateResponse)
        } catch {
            self.isUpLoadingError = error.localizedDescription
        }
    }
    
    private func uploadImages(_ responseData: ResponseData) async throws {
        do {
            if let mainImageURL = titleImageURL,
               let url = URL(string: responseData.mainPresignedUrl) {
                // 메인 이미지 업로드
                let (data, response) = try await URLSession.shared.upload(to: url, fileURL: mainImageURL)
                print("메인 이미지 Upload Response: \(response), \(data)")
            }
            
            for (index, processURL) in responseData.recipeProcessPresignedUrl.enumerated() {
                var processImageURL : URL?
                for (index , recipeStep) in recipeStepData.enumerated() {
                    if recipeStep.isUpdate {
                        processImageURL = recipeStep.imageURL
                        DispatchQueue.main.async { [self] in
                            recipeStepData[index].isUpdate = false
                        }
                        break
                    }
                }

                guard let processURLstr = URL(string: processURL) else { throw UploadError.invalidURL }
                guard let processImageURL = processImageURL  else { throw UploadError.invalidURL }
                
                let (data, response) = try await URLSession.shared.upload(to: processURLstr,
                                                                          fileURL: processImageURL)
            }
                    
            self.isUpLoading = false
        } catch {
            self.isUpLoading = false
            self.isUpLoadingError = error.localizedDescription
            throw UploadError.fileExtension
        }
    }
    
    
}

extension URLSession {
    func upload(to url: URL, fileURL: URL, httpMethod: String = "PUT", headers: [String: String] = [:]) async throws -> (Data, URLResponse) {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        switch fileURL.pathExtension.lowercased() {
        case "jpg", "jpeg":
            request.allHTTPHeaderFields = HTTPHeaderField.jpgImageUpload
        case "png":
            request.allHTTPHeaderFields = HTTPHeaderField.pngImageUpload
        default:
            throw UploadError.invalidURL
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            let task = self.uploadTask(with: request, fromFile: fileURL) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data, let response = response, let httpResponse = response as? HTTPURLResponse {
                    if 200..<300 ~= httpResponse.statusCode {
                        continuation.resume(returning: (data, response))
                    } else {
                        let error = NSError(domain: "이미지 업로드 실패.", code: httpResponse.statusCode)
                        continuation.resume(throwing: error)
                    }
                } else {
                    print("?????????????")
                }
            }
            task.resume()
        }
    }
    
}

enum UploadError: Error {
    case invalidURL
    case uploadFailed
    case fileExtension
    case noImage
}
