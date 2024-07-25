//
//  ChangePasswordViewModel.swift
//  EatCook
//
//  Created by 강신규 on 7/25/24.
//

import Foundation
import Combine


class ChangePasswordViewModel : ObservableObject {
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
    
    private var cancellables = Set<AnyCancellable>()
    
    
    
    
    init(email : String){
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
    
    
    func changePassword(completion: @escaping (FindNewPasswordResponse) -> Void) {
        UserService.shared.findNewPassword(parameters: ["email": email, "password" : newPassword], success: { (data) in
            print("data : " , data)
            DispatchQueue.main.async {
                completion(data)
            }
        }, failure: { (errorData) in
            DispatchQueue.main.async {
                completion(errorData)
            }
        })
        
        
    }
    
    
    
    
}
