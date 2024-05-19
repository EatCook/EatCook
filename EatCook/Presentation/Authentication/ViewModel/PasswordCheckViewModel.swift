//
//  PasswordViewModel.swift
//  EatCook
//
//  Created by 강신규 on 5/19/24.
//

import Foundation
import Combine

class PasswordChcekViewModel : ObservableObject {
    
    @Published var password: String = ""
    @Published var passwordCheck: String = ""
    @Published var isValidPassword : Bool = false
    
    @Published var isLengthValid = false
    @Published var containsLetter = false
    @Published var containsNumber = false
    
    
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
        // Check length validity
        $password
            .map { $0.count >= 8 }
            .assign(to: \.isLengthValid, on: self)
            .store(in: &cancellables)
        
        // Check if password contains a letter
        $password
            .map { $0.range(of: "[A-Za-z]", options: .regularExpression) != nil }
            .assign(to: \.containsLetter, on: self)
            .store(in: &cancellables)
        
        // Check if password contains a number
        $password
            .map { $0.range(of: "[0-9]", options: .regularExpression) != nil }
            .assign(to: \.containsNumber, on: self)
            .store(in: &cancellables)
        
        
        // Combine all validity checks
        Publishers.CombineLatest3($isLengthValid, $containsLetter, $containsNumber)
            .map { $0 && $1 && $2 }
            .assign(to: \.isValidPassword, on: self)
            .store(in: &cancellables)
        
        
    }
    
    private func validatePassword(password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    
    func passwordValidationCheck() -> Bool {
        
        return password == passwordCheck ? true : false
        
    }
    
    
    
    
    
}
