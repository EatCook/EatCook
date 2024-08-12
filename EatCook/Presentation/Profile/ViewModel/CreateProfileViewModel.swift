//
//  CreateProfileViewModel.swift
//  EatCook
//
//  Created by 강신규 on 7/30/24.
//

import Foundation
import Combine
import SwiftUI

class CreateProfileViewModel : ObservableObject {
    
    private let authUseCase : AuthUseCase
    private var cancellables = Set<AnyCancellable>()
    
    @Published var nickname: String = "" {
        didSet {
            validate()
        }
    }
    @Published var isNickNameImageValid: Bool = false
    
    @Published var userImage: UIImage? = nil {
        didSet {
            validate()
        }
    }

    @Published var userImageURL: URL?
    @Published var userImageExtension: String?
    
    
    init(authUseCase: AuthUseCase) {
        self.authUseCase = authUseCase
        
    }
    
    
    

    private func validate() {
        let isValidNickname = isValidKoreanNickname(nickname)
        let hasImage = userImage != nil
        isNickNameImageValid = isValidNickname && hasImage
    }
    
    private func isValidKoreanNickname(_ nickname: String) -> Bool {
        let pattern = "^[가-힣]{2,6}$"
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: nickname.utf16.count)
        return regex?.firstMatch(in: nickname, options: [], range: range) != nil
    }
    
 
}

extension CreateProfileViewModel {
    
    func checkNickName(completion: @escaping (Bool) -> Void) {
        
        authUseCase.checkNickName(nickname)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("CreateProfileViewModel CheckNickName Finished")
                    
                case .failure(let error):
                    print("error:", error)
                    switch error {
                    case .unauthorized:
                        print("소셜 로그인 토큰 에러")
                        
                    default:
                        print("기본 에러처리")
                    }
                    
                    print("CreateProfileViewModel CheckNickName Error \(error)")
                }
                
            } receiveValue: { response in
                print("CreateProfileViewModel CheckNickNamel response:" , response)
                if response.success {
                    return completion(true)
                }else{
                    return completion(false)
                }
                
            }
            .store(in: &cancellables)
        
          
//        UserService.shared.checkNickName(parameters: ["nickName" : nickname]) { result in
//            print("result :", result)
//            completion(result)
//        } failure: { errorResult in
//            print("Error result")
//            completion(errorResult)
//        }
    }
    
    
}
