//
//  FindAccountViewModel.swift
//  EatCook
//
//  Created by 강신규 on 7/30/24.
//

import Foundation
import Combine

class FindAccountViewModel : ObservableObject {
    @Published var email: String = ""
    @Published var emailText : String = "인증요청"
    @Published var authCode : String = ""
    @Published var counter = 180 // 3분에 해당하는 초
    @Published var isTimerRunning = false // 시작할 때 타이머 실행 여부
    @Published var emailAuthError : Bool = false
    @Published var authCodeValidation : Bool = false
    @Published var isEmailValid: Bool = false
    @Published var isLoading: Bool = false
    
    @Published var verificationResult: Bool?
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var emailValidationSubscriber: AnyCancellable?
    private var verificationSubscriber: AnyCancellable?
    private var authCodeValidationSubscriber : AnyCancellable?
    
    let emailValidationPublisher = PassthroughSubject<String, Never>()
    
    
    init() {
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
    

    func counterToMinutesAndSeconds(_ count: Int) -> String {
        let minutes = count / 60
        let seconds = count % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func stopTimer() {
        timer.upstream.connect().cancel()
        self.isTimerRunning = false
    }
    
    func startTimer() {
        self.counter = 180
        self.isTimerRunning = true
    }
    
    // 이메일 유효성 검사 함수
    func isValidEmail(_ email: String) -> Bool {
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
    
    func sendEmail(completion: @escaping (FindAccountResponseDTO) -> Void) {
        
        UserService.shared.findAccountSendMail(parameters: ["email" : email], success: { (data) in
            
            DispatchQueue.main.async {
                completion(data)
            }
            
        }, failure: { (errorData) in
            DispatchQueue.main.async {
                completion(errorData)
            }
        })
        
        
    }
    
    func verify(completion: @escaping (FindAccountVerifyResponseDTO) -> Void) {
        
        UserService.shared.findAccountVerify(parameters: ["email" : email, "authCode" : authCode], success: { [weak self] (data) in
            DispatchQueue.main.async {
                completion(data)
                print("data : ", data)
            }
        }, failure: { (errorData) in
            DispatchQueue.main.async {
                completion(errorData)
            }
        })
        
        
    }

    
    
    
    
    
    
}

