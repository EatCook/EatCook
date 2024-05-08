//
//  EmailAuthView.swift
//  EatCook
//
//  Created by 김하은 on 2/10/24.
//

import SwiftUI
import Combine

struct EmailAuthView: View {
//    @State private var email: String = ""
//    @State private var isEmailValid: Bool = false
  
    @StateObject private var emailValViewModel = EmailValidationViewModel()
    private var networkManager = TestNetworkManager()
    
    
    @State var authNumber = ""
    @State var isAuthRequest = false


    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("이메일을 인증해 주세요")
                    .font(.title2)
                    .padding(.vertical, 28)
                
                HStack {
                    TextField("이메일", text: $emailValViewModel.email).modifier(CustomTextFieldModifier())
                    
                    Button(action: {
                        emailValViewModel.isLoading = true
                        emailValViewModel.emailValidationPublisher.send(emailValViewModel.email)
                        
                        print("fetchStart")
                        
                        networkManager.fetchData { result in
                            
                            print("result::", result)
                            switch result {
                            case .success(let receivedData):
                                // 데이터를 원하는 형식으로 처리합니다.
                                print("receivedData:", receivedData)
                                
                            case .failure(let error):
                                print("Error: \(error.localizedDescription)")
                            }
                        }
                            
                        
                    }, label: {
                        Text("인증요청")
                            .font(.callout)
                            .foregroundStyle(emailValViewModel.isEmailValid ? Color.white : Color.gray5)
                    })
                    .frame(width: 80,height: 55)
                    .background(emailValViewModel.isEmailValid ? Color.primary7 : Color.gray3)
                    .cornerRadius(10)
                    .disabled(!emailValViewModel.isEmailValid || emailValViewModel.isLoading)
                }.padding(.vertical, 14)
                .padding(.horizontal, 24)
                
                HStack {
                    TextField("인증번호", text: $authNumber).modifier(CustomTextFieldModifier())
                
                    Button(action: {
                        
                    }, label: {
                        Text("3:00")
                    })
                    .frame(width: 80,height: 55)
                    .background(isAuthRequest ? Color.bdActive : Color.bdInactive)
                    .cornerRadius(10)
                }.padding(.bottom, 14)
                .padding(.horizontal, 24)
                
                NavigationLink(destination: PasswordCheckView().toolbarRole(.editor)) {
                    Text("다음")
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(isAuthRequest ? Color.bdActive : Color.bdInactive)
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
                }

                Spacer()
            }
            .padding(.top, 30)
        
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.bgPrimary)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("회원가입").bold()
        }
    }
}

#Preview {
    EmailAuthView()
}
