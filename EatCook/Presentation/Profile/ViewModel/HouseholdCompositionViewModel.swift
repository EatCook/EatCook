//
//  HouseholdCompositionViewModel.swift
//  EatCook
//
//  Created by 강신규 on 7/30/24.
//

import Foundation
import Combine
import SwiftUI

class HouseholdCompositionViewModel : ObservableObject {
    private let authUseCase : AuthUseCase
    private var cancellables = Set<AnyCancellable>()
    
    
   
    @Published var email: String = ""
    @Published var nickName: String = ""
    @Published var cookingType: [String] = []
    @Published var imageURL: URL? = nil
//    @Published var userImageURL: URL?
    @Published var userImageExtension : String? = nil
    @Published var lifeType : String = ""
    
    @Published var isUpLoading: Bool = false
    @Published var isUpLoadingError: String? = nil
    
    @Published var addSignUpImageUpdateResponse = AddSignUpResponseData(presignedUrl: "")
    
    
    init(authUseCase : AuthUseCase ,email: String = "", nickName : String = "" ,cookingType: [String] = [], imageURL: URL? = nil , userImageExtension : String? = nil) {
        self.authUseCase = authUseCase
        self.email = email
        self.nickName = nickName
        self.cookingType = cookingType
        self.imageURL = imageURL
        self.userImageExtension = userImageExtension
    }
    

    
    

}

extension HouseholdCompositionViewModel {
    
    func addSignUp() async {
        isUpLoading = true
        isUpLoadingError = nil
        
        guard let userImageExtension = userImageExtension , let userImage = imageURL else {
            print(" userImageExtension , userImage nil 오류")
            return
        }
        
        return await withCheckedContinuation { continuation in
            authUseCase.addSignUp(email, userImageExtension, nickName, cookingType, lifeType)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        continuation.resume()
                        print("HouseholdCompositionViewModel addSignUp Finished")
                        
                    case .failure(let error):
                        print("error:", error)
                        switch error {
                        case .unauthorized:
                            print("회원가입 추가신청 토큰 에러")
                            
                        default:
                            DispatchQueue.main.async {
                                self.isUpLoading = false
                                self.isUpLoadingError = error.localizedDescription
                            }
                            print("기본 에러처리")
                        }
                        
                        print("HouseholdCompositionViewModel addSignUp Error \(error)")
                    }
                    
                } receiveValue: { response in
                    print("HouseholdCompositionViewModel addSignUp response:" , response)
                    DispatchQueue.main.async {
                        self.isUpLoading = false
                        self.addSignUpImageUpdateResponse = response.data
                    }
                   
                    
                }
                .store(in: &cancellables)
        }
        
    }
    
    
    func uploadImage() async {
        do {
            try await self.uploadImages(addSignUpImageUpdateResponse)
        } catch {
            DispatchQueue.main.async {
                self.isUpLoadingError = error.localizedDescription
            }
        }
    }
    
    private func uploadImages(_ responseData: AddSignUpResponseData) async throws {
        do {
            guard let userImageURL = imageURL,
                  let url = URL(string: responseData.presignedUrl) else { throw UploadError.invalidURL }
            
            let (data, response) = try await URLSession.shared.upload(to: url,
                                                                      fileURL: userImageURL)
            
            print("회원 가입 추가요청 Upload Response: \(response), \(data)")
            
            DispatchQueue.main.async {
                self.isUpLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.isUpLoading = false
                self.isUpLoadingError = error.localizedDescription
            }
            throw UploadError.fileExtension
        }
    }
    
    
}


enum AddSignUpResult {
    case success(AddSignUpResponse)
    case failure(Error)
}
