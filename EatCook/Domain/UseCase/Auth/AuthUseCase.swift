//
//  AuthUseCase.swift
//  EatCook
//
//  Created by 강신규 on 8/11/24.
//

import Foundation
import Combine

final class AuthUseCase {
    
    private let eatCookRepository: EatCookRepositoryType
    private var cancellabels = Set<AnyCancellable>()
    
    init(eatCookRepository: EatCookRepositoryType) {
        self.eatCookRepository = eatCookRepository
    }
    
    
}


extension AuthUseCase {
    
    
    func requestEmail(_ email : String ) -> AnyPublisher<EmailRequestResponse, NetworkError> {
        return eatCookRepository
            .requestEmail(of: AuthAPI.emailRequest(email))
            .eraseToAnyPublisher()
    }
    
    func emailVerify(_ email : String , _ authCode : String) -> AnyPublisher<EmailVerifyResponse, NetworkError> {
        return eatCookRepository
            .emailVerify(of: AuthAPI.emailVerify(email, authCode))
            .eraseToAnyPublisher()
    }
    
    func signUp(_ email : String , _ password : String) -> AnyPublisher<SignUpResponse, NetworkError> {
        return eatCookRepository
            .signUp(of: AuthAPI.signUp(email, password))
            .eraseToAnyPublisher()
    }
    
    
}
