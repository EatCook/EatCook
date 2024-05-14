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
        
  
        // JSON 데이터 생성
        let parameters = ["email": "rkdtlscks123@naver.com"]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
            print("Failed to serialize JSON")
            return
        }
        
        // URLRequest 생성 및 설정
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        
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
    
    func fetchEmailData(completion: @escaping (Result<ResponseData, Error>) -> Void, authCode : String ) {
        
        print(authCode)
        
        // URL을 생성합니다. 예를 들어, https://api.example.com/data로 요청하는 경우:
        guard let url = URL(string: "http://52.79.243.219:8080/api/v1/emails/verify") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
  
        // JSON 데이터 생성
        let parameters = ["email": "rkdtlscks123@naver.com", "authCode" : authCode]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
            print("Failed to serialize JSON")
            return
        }
        
        // URLRequest 생성 및 설정
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        
        // URLSession을 사용하여 데이터를 요청합니다.
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("data ::" , data)
            print(response)
            

            
            if let response = response as? HTTPURLResponse {
                print("response ::::: ", response)
                
                guard let data = data else {
    //                completion(nil, .noData)
                    print("NO DATA")
                    return
                }
                
                do {
                    if let responseBody = String(data: data, encoding: .utf8) {
                        print("Response body: \(responseBody)")
                    } else {
                        print("Failed to convert data to string")
                    }
                    //                    completion(result, nil)
                    
                    
                } catch {
                    print("ERROR")
                }
                
                // 데이터 확인 및 디코딩
                do {
                    // JSON 데이터를 MyData 구조체로 디코딩합니다.
                    let decodedData = try JSONDecoder().decode(ResponseData.self, from: data)
                    
//                    let jsonData = try JSONEncoder().encode(decodedData)
                    
                    // 사용할 데이터를 출력하거나 다른 작업을 수행합니다.
                    print("decodedData ::" , decodedData)
                    completion(.success(decodedData))
                    
                } catch {
                    print("Error decoding JSON: \(error)")
                }
                            
            }
            
            
//            // 요청이 실패한 경우
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            // 응답 데이터가 있는 경우
//            if let data = data {
//                completion(.success(data))
//            } else {
//                // 응답 데이터가 없는 경우
//                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
//            }
        }.resume()
    }
    
    
}

struct ResponseData: Codable {
    let success: Bool
    let code: String
    let message: String
    let data: String? // 데이터의 타입에 따라 적절히 수정 가능
}

class EmailValidationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var isEmailValid: Bool = false
    
    @Published var isLoading: Bool = false
    @Published var verificationResult: Bool?
    
    @Published var authCode = ""
    @Published var authCodeValidation : Bool = false

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
