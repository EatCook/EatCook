//
//  FindAccountView.swift
//  EatCook
//
//  Created by 강신규 on 7/23/24.
//

import SwiftUI

struct FindAccountView: View {
    
    @StateObject private var findAccountViewModel = FindAccountViewModel()
    @State private var navigateToChangePasswordView = false
    @State private var shake = false

    
    var body: some View {
        NavigationStack {
            
            VStack {
                Text("이메일을 인증해 주세요")
                    .font(.title2)
                    .padding(.vertical, 28)
                
                HStack {
                    TextField("이메일", text: $findAccountViewModel.email).modifier(CustomTextFieldModifier())
                    
                    Button(action: {
                        findAccountViewModel.isLoading = true
                        findAccountViewModel.emailValidationPublisher.send(findAccountViewModel.email)
                        findAccountViewModel.sendEmail { result in
                            if result.success {
                                findAccountViewModel.startTimer()
                            }
                            
                        }
                        

                        
                        
                    }, label: {
                        Text(findAccountViewModel.emailText)
                            .font(.callout)
                            .foregroundStyle((findAccountViewModel.isEmailValid && !findAccountViewModel.isTimerRunning) ? Color.white : Color.gray5)
                    })
                    .frame(width: 80,height: 55)
                    .background((findAccountViewModel.isEmailValid && !findAccountViewModel.isTimerRunning)  ? Color.primary7 : Color.gray3)
                    .cornerRadius(10)
                    .disabled(!findAccountViewModel.isEmailValid || findAccountViewModel.isLoading || findAccountViewModel.isTimerRunning)
                }.padding(.vertical, 14)
                .padding(.horizontal, 24)
                
                if !findAccountViewModel.email.isEmpty && !findAccountViewModel.isEmailValid {
                    HStack() {
                        Image(.error).resizable().frame(width : 15, height: 15)
                        Text("이메일 주소 형식에 맞지 않아요!").font(.system(size : 14)).font(.callout).foregroundColor(.error4)
                        Spacer()
                    }.padding(.horizontal, 24)
                }
                
               
                
                
                ZStack(alignment : .trailing) {
                    HStack {
                        TextField("인증번호 6자리 입력", text: $findAccountViewModel.authCode).modifier(CustomTextFieldModifier())
                    }
                    
                    if findAccountViewModel.isTimerRunning {
                        Text("\(findAccountViewModel.counterToMinutesAndSeconds(findAccountViewModel.counter))").onReceive(findAccountViewModel.timer){ _ in
                            guard findAccountViewModel.isTimerRunning else { return }
                            
                            if findAccountViewModel.counter > 0 {
                                findAccountViewModel.counter -= 1
                            }else{
                                findAccountViewModel.emailText = "재요청"
                                findAccountViewModel.stopTimer()
                            }
                                
                        }.font(.system(size : 14)).font(.callout).foregroundColor(.primary7)
                            .padding(.trailing , 12)
                        
                    }
                    
                     
                    
                }.padding(.bottom, 14)
                .padding(.horizontal, 24)
                    
                
                if findAccountViewModel.emailAuthError {
                    HStack() {
                        Image(.error).resizable().frame(width : 15, height: 15)
                        Text("인증번호가 일치하지 않습니다").font(.system(size : 14)).font(.callout).foregroundColor(.error4)
                        Spacer()
                    }
                    .modifier(ShakeEffect(animatableData: CGFloat(shake ? 1 : 0)))
                    .padding(.horizontal, 24)
                }
                
                
                Button(action: {
                    findAccountViewModel.verify { result in
                        if result.success {
                            print("SUCCESS")
                            navigateToChangePasswordView = true
                        }else{
                            withAnimation {
                                findAccountViewModel.emailAuthError = true
                                shake.toggle()
                            }
                            print("ERROR")
                        }
                    }
                }, label: {
                    Text("다음")
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .foregroundColor(.white)
                    .background(findAccountViewModel.authCodeValidation ? Color.primary7 : Color.primary4)
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
                })
                .disabled(!findAccountViewModel.authCodeValidation)
                
                NavigationLink(destination: ChangePasswordView(email: findAccountViewModel.email).toolbarRole(.editor), isActive: $navigateToChangePasswordView) {
                    EmptyView()
                }

                Spacer()
            }
            .padding(.top, 30)
        
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.bgPrimary)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("계정찾기").bold()
            
            
            
        }
        

    }
}

#Preview {
    FindAccountView()
}
