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

    @State var authNumber = ""
    @State var isAuthRequest = false
    
    @State private var counter = 180 // 3분에 해당하는 초
    @State private var isTimerRunning = false // 시작할 때 타이머 실행 여부
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var emailText : String = "인증요청"
    @State var emailAuthError : Bool = false
    
    
    @State private var isActive = true
    @State var tag:Int? = nil
    
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
                        
                        UserService.shared.requestEmail(parameters: ["email" : emailValViewModel.email], success: { (data) in
                            self.startTimer()

                            print("data : " , data)
                            
                        }, failure: { (error) in

                        })
                        
                        
                            
                        
                    }, label: {
                        Text(emailText)
                            .font(.callout)
                            .foregroundStyle((emailValViewModel.isEmailValid && !isTimerRunning) ? Color.white : Color.gray5)
                    })
                    .frame(width: 80,height: 55)
                    .background((emailValViewModel.isEmailValid && !isTimerRunning) ? Color.primary7 : Color.gray3)
                    .cornerRadius(10)
                    .disabled(!emailValViewModel.isEmailValid || emailValViewModel.isLoading || isTimerRunning)
                }.padding(.vertical, 14)
                .padding(.horizontal, 24)
                
                ZStack(alignment : .trailing) {
                    HStack {
                        TextField("인증번호 6자리 입력", text: $emailValViewModel.authCode).modifier(CustomTextFieldModifier())
                        
                        
                    }
                    
                    if isTimerRunning {
                        Text("\(counterToMinutesAndSeconds(counter))").onReceive(timer){ _ in
                            guard self.isTimerRunning else { return }
                            
                            if self.counter > 0 {
                                self.counter -= 1
                            }else{
                                emailText = "재요청"
                                self.stopTimer()
                            }
                                
                        }.font(.system(size : 14)).font(.callout).foregroundColor(.primary7)
                            .padding(.trailing , 12)
                        
                    }
                    
                    
                    
                }.padding(.bottom, 14)
                .padding(.horizontal, 24)
                    
                
                if emailAuthError {
                    HStack() {
                        Image(.error).resizable().frame(width : 20, height: 20)
                        Text("인증번호가 일치하지 않습니다").font(.system(size : 14)).font(.callout).foregroundColor(.error4)
                        Spacer()
                    }.padding(.horizontal, 24)
                }
                
                
                Button(action: {
                    
                    UserService.shared.requestEmail(parameters: ["email": emailValViewModel.email, "authCode" : emailValViewModel.authCode], success: { (data) in
                       
                        print("data : " , data)
                        // Hidden NavigationLink that becomes active based on the state
                        self.tag = 1
         
                        
                       
                        
                    }, failure: { (error) in

                    })
                    
                }, label: {
                    Text("다음")
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .foregroundColor(.white)
                    .background(emailValViewModel.authCodeValidation ? Color.primary7 : Color.primary4)
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
                })
                .disabled(!emailValViewModel.authCodeValidation)
                
                NavigationLink(destination:  PasswordCheckView(email: emailValViewModel.email).toolbarRole(.editor), tag: 1, selection: self.$tag) {
                    EmptyView()
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
