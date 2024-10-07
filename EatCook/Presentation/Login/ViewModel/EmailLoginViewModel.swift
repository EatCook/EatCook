//
//  EmailLoginViewModel.swift
//  EatCook
//
//  Created by 강신규 on 7/30/24.
//


import Foundation
import Combine


class EmailLoginViewModel : ObservableObject {
    
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var email : String = ""
    @Published var password : String = ""
    
    
    private let loginUseCase : LoginUseCase
    let loginUserInfo: LoginUserInfoManager
    
    
    init(loginUseCase: LoginUseCase , loginUserInfo: LoginUserInfoManager) {
        self.loginUseCase = loginUseCase
        self.loginUserInfo = loginUserInfo
    }
    

    
}


extension EmailLoginViewModel {
    
    func emailLogin(completion: @escaping (LoginResponse) -> Void) {
        
        let deviceToken =  DataStorage.shared.getString(forKey: DataStorageKey.PUSH_TOKEN)
        loginUseCase.login(email, password, deviceToken)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("로그인 성공")
                  
                case .failure(let error):
                    print("로그인 실패 \(error.localizedDescription)")
                }
            } receiveValue: { response in
                print(response)
                completion(response)
            }
            .store(in: &cancellables)

        
        
    }

    
    
}


