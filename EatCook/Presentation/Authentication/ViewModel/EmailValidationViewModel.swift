//
//  EmailValidationViewModel.swift
//  EatCook
//
//  Created by 강신규 on 7/30/24.
//

import Foundation
import Combine

class EmailValidationViewModel: ObservableObject {
    
    private let authUseCase : AuthUseCase
    private var cancellables = Set<AnyCancellable>()
    @Published var email: String = ""
    @Published var isEmailValid: Bool = false
    
    @Published var isLoading: Bool = false
    @Published var verificationResult: Bool?
    
    @Published var authCode = ""
    @Published var authCodeValidation : Bool = false
    
    @Published var emailTextFieldDisabled : Bool = false
    

    private var emailValidationSubscriber: AnyCancellable?
    private var verificationSubscriber: AnyCancellable?
    private var authCodeValidationSubscriber : AnyCancellable?
    
    let emailValidationPublisher = PassthroughSubject<String, Never>()
    
    
    init(authUseCase: AuthUseCase) {
        self.authUseCase = authUseCase
        emailValidationSubscriber = $email
            .debounce(for: 0.5, scheduler: RunLoop.main) // 입력이 멈출 때마다 발행을 지연시킴
            .removeDuplicates() // 중복된 값 제거
            .map { self.isValidEmail($0) } // 입력값을 검증하고 유효성을 판단
            .receive(on: RunLoop.main) // 메인 스레드에서 수신
            .assign(to: \.isEmailValid, on: self) // 결과를 isEmailValid에 할당
        
        verificationSubscriber = emailValidationPublisher
                   .flatMap { email in
                       self.verifyEmail(email)
                   }
                   .sink(receiveValue: { result in
                       self.isLoading = false
                       self.verificationResult = result
                   })
        
        authCodeValidationSubscriber = $authCode.sink { [weak self] value in
            if value.count == 6 {
                // 여기에서 6자리의 번호가 입력되었을 때 원하는 동작을 수행합니다.
                print("Entered number: \(value)")
                self?.authCodeValidation = true
                // 여기에 원하는 동작을 추가할 수 있습니다.
            }else{
                self?.authCodeValidation = false
            }
        }
        
    }
    

    


    // 이메일 유효성 검사 함수
    private func isValidEmail(_ email: String) -> Bool {
        // 간단한 정규식을 사용하여 이메일 형식이 맞는지 확인
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func verifyEmail(_ email: String) -> AnyPublisher<Bool, Never> {
        // 네트워크 요청을 통해 이메일 인증을 확인하는 로직을 여기에 구현
        // 여기서는 간단한 예시로 항상 true를 반환하도록 함
        return Just(true)
            .eraseToAnyPublisher()
    }

    
}

extension EmailValidationViewModel {
    
    func requestEmail(email : String , completion :  @escaping (Bool) -> Void) {
        authUseCase.requestEmail(email)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("EmailValidationViewModel  requestEmail Finished")
                    
                case .failure(let error):
                    print("error:", error)
                    switch error {
                    case .unauthorized:
                        print("EmailValidationViewModel token Error")
                        
                    default:
                        print("기본 에러처리")
                    }
                    
                    print("EmailValidationViewModel Error: \(error)")
                }
                
            } receiveValue: { response in
                print("AuthView requestEmail response:" , response)
                if response.success {
                    self.emailTextFieldDisabled = true
                    return completion(true)
                }else{
                    return completion(false)
                }
                
            }
            .store(in: &cancellables)
        
    }
    
    func emailVerify(email : String , authCode : String , completion :  @escaping (Bool) -> Void) {
        authUseCase.emailVerify(email, authCode)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("EmailValidationViewModel authCode Finished")
                    
                case .failure(let error):
                    print("error:", error)
                    switch error {
                    case .unauthorized:
                        print("EmailValidationViewModel authCode Token Error")
                        
                    default:
                        print("기본 에러처리")
                    }
                    
                    print("EmailValidationViewModel Error: \(error)")
                }
                
            } receiveValue: { response in
                print("AuthView authCode response:" , response)
                if response.success {
                    return completion(true)
                }else{
                    return completion(false)
                }
                
            }
            .store(in: &cancellables)
        
    }
    
    
}
