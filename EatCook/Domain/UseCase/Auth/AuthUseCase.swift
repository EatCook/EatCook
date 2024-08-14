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
    
    func checkNickName(_ nickName : String) -> AnyPublisher<CheckNickNameResponse, NetworkError> {
        return eatCookRepository
            .checkNickName(of: AuthAPI.checkNickName(nickName))
            .eraseToAnyPublisher()
    }
    
    func addSignUp(_ email : String , _ fileExtension : String, _ nickName : String , _ cookingType : [String] , _ lifeType : String) -> AnyPublisher<AddSignUpResponse, NetworkError> {
        return eatCookRepository
            .addSignUp(of: AuthAPI.addSignUp(email, fileExtension, nickName, cookingType, lifeType))
            .eraseToAnyPublisher()
    }
    
    func findPasswordRequestEmail(_ email : String) -> AnyPublisher<FindAccountResponse, NetworkError> {
        return eatCookRepository
            .findPasswordRequestEmail(of: AuthAPI.findPasswordRequestEmail(email))
            .eraseToAnyPublisher()
    }
    
    func findPasswordEmailVerify(_ email : String , _ authCode : String) -> AnyPublisher<FindAccountVerifyResponse, NetworkError> {
        return eatCookRepository
            .findPasswordEmailVerify(of: AuthAPI.findPasswordEmailVerify(email, authCode))
            .eraseToAnyPublisher()
    }
    
    func setNewPassword(_ email : String , _ password : String) -> AnyPublisher<FindNewPasswordResponse, NetworkError> {
        return eatCookRepository
            .setNewPassword(of: AuthAPI.setNewPassword(email, password))
            .eraseToAnyPublisher()
    }
    
}
