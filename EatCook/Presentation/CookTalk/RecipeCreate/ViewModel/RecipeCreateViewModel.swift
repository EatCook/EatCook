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
    @Published var titleImageURL: URL?
    @Published var titleImageExtension: String?
    
    /// 두번째
    @Published var ingredientsInputText: String = ""
    @Published var ingredientsTags: [Tag] = []
    
    /// 세번째
    @Published var recipeStepData: [RecipeStep] = []
    @Published var recipeStepImage: UIImage?
    @Published var recipeStepImageURL: URL?
    @Published var recipeStepImageExtension: String?
    
    /// 레시피 생성 과정 담긴 모델 -> 요청시 DTO로 변경함.
    @Published var recipeCreateData = RecipeCreateRequest()
    
    @Published var isUpLoading: Bool = false
    @Published var isUpLoadingError: String? = nil
    
    /// Response 모델
    @Published var recipeCreateResponse = ResponseData()
    
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
    func requestRecipeCreate() async {
        isUpLoading = true
        isUpLoadingError = nil
        
        let recipeCreateDTO = RecipeCreateRequestDTO(email: recipeCreateData.email,
                                                     recipeName: recipeCreateData.recipeName,
                                                     recipeTime: recipeCreateData.recipeTime,
                                                     introduction: recipeCreateData.introduction,
                                                     mainFileExtension: recipeCreateData.mainFileExtension,
                                                     foodIngredients: recipeCreateData.foodIngredients,
                                                     cookingType: recipeCreateData.cookingType,
                                                     recipeProcess: recipeCreateData.recipeProcess.map { $0.toData() })
        
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
    
    func uploadImage() async {
        do {
            try await self.uploadImages(recipeCreateResponse)
        } catch {
            self.isUpLoadingError = error.localizedDescription
        }
    }
    
    private func uploadImages(_ responseData: ResponseData) async throws {
        do {
            guard let mainImageURL = titleImageURL,
                  let url = URL(string: responseData.mainPresignedUrl) else { throw UploadError.invalidURL }
            
            let (data, response) = try await URLSession.shared.upload(to: url,
                                                                      fileURL: mainImageURL)
            
            print("메인 이미지 Upload Response: \(response), \(data)")
            for (index, processURL) in responseData.recipeProcessPresignedUrl.enumerated() {
                let processImageURL = recipeStepData[index].imageURL
                guard let processURLstr = URL(string: processURL),
                      let processImageURL = processImageURL else { throw UploadError.invalidURL }
                let (data, response) = try await URLSession.shared.upload(to: processURLstr,
                                                                          fileURL: processImageURL)
                print("스텝 이미지 Upload Response: \(response), \(data)")
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
}
