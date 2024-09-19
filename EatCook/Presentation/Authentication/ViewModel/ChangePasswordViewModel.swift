//
//  ChangePasswordViewModel.swift
//  EatCook
//
//  Created by 강신규 on 7/30/24.
//

import Foundation
import Combine


class ChangePasswordViewModel : ObservableObject {
    
    private let authUseCase : AuthUseCase
    private var cancellables = Set<AnyCancellable>()
    
    
    @Published var email: String
    
    @Published var newPassword: String = ""
    @Published var newPasswordCheck: String = ""
    @Published var newPasswordSecure : Bool = false
    @Published var newPasswordCheckSecure : Bool = false
    @Published var isValidPassword : Bool = false
    @Published var isLengthValid = false
    @Published var containsLetter = false
    @Published var containsNumber = false
    @Published var isPasswordError = false
    
    //에러처리
    @Published var showSuccessAlert : Bool = false
    @Published var showErrorAlert : Bool = false
    @Published var baseAlertInfo = BaseAlertInfo(title: "에러", message: "")

    
    init(email : String , authUseCase: AuthUseCase){
        self.authUseCase = authUseCase
        self.email = email
        
        // 8자리 이상 확인
        $newPassword
            .map { $0.count >= 8 }
            .assign(to: \.isLengthValid, on: self)
            .store(in: &cancellables)
        
        // 문자 포함 확인
        $newPassword
            .map { $0.range(of: "[A-Za-z]", options: .regularExpression) != nil }
            .assign(to: \.containsLetter, on: self)
            .store(in: &cancellables)
        
        // 숫자 포함 확인
        $newPassword
            .map { $0.range(of: "[0-9]", options: .regularExpression) != nil }
            .assign(to: \.containsNumber, on: self)
            .store(in: &cancellables)
        
        
        // 8자리 , 문자 , 숫자 체크
        Publishers.CombineLatest3($isLengthValid, $containsLetter, $containsNumber)
            .map { $0 && $1 && $2 }
            .assign(to: \.isValidPassword, on: self)
            .store(in: &cancellables)
        
        
        
    }
    

    func passwordValidationCheck() -> Bool {
        
        return newPassword == newPasswordCheck ? true : false
        
    }
    
    
}

extension ChangePasswordViewModel {
    
    func changePassword(completion: @escaping (Bool) -> Void) {
        authUseCase.setNewPassword(email, newPassword)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("ChangePasswordViewModel setNewPassword Finished")
                    
                case .failure(let error):
                    print("error:", error)
                    switch error {
                    case .customError(let message):
                        self.baseAlertInfo.message = message
                        self.showErrorAlert = true
                    case .unauthorized:
                        print("ChangePasswordViewModel setNewPasswordToken Error")
                        
                    default:
                        print("기본 에러처리")
                    }
                    
                    print("ChangePasswordViewModel setNewPassword Error: \(error)")
                }
                
            } receiveValue: { response in
                print("ChangePasswordViewModel setNewPassword response:" , response)
                if response.success {
                    return completion(true)
                }else{
                    return completion(false)
                }
                
            }
            .store(in: &cancellables)
        
    }
    
}
