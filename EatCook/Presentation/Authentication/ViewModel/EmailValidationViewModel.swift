//
//  EmailValidationViewModel.swift
//  EatCook
//
//  Created by 강신규 on 5/8/24.
//

import Foundation
import Combine

class TestNetworkManager {
    func fetchData(completion: @escaping (Result<Data, Error>) -> Void) {
        
        
        // URL을 생성합니다. 예를 들어, https://api.example.com/data로 요청하는 경우:
        guard let url = URL(string: "http://52.79.243.219:8080/api/v1/emails/request") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        // URLRequest 생성
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // HTTP 요청에 포함될 파라미터 설정
        let parameters = ["email": "rkdtlscks123@naver.com"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        
        
        // URLSession을 사용하여 데이터를 요청합니다.
        URLSession.shared.dataTask(with: request) { data, response, error in
            // 요청이 실패한 경우
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // 응답 데이터가 있는 경우
            if let data = data {
                completion(.success(data))
            } else {
                // 응답 데이터가 없는 경우
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
            }
        }.resume()
    }
}

class EmailValidationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var isEmailValid: Bool = false
    
    @Published var isLoading: Bool = false
    @Published var verificationResult: Bool?

    private var emailValidationSubscriber: AnyCancellable?
    private var verificationSubscriber: AnyCancellable?
    
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
