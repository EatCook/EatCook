//
//  EmailLoginView.swift
//  EatCook
//
//  Created by 강신규 on 5/25/24.
//

import SwiftUI

struct EmailLoginView: View {
    
    @StateObject private var emailLoginViewModel = EmailLoginViewModel()
    @State private var isSecure = true
    @StateObject private var toastManager = ToastManager()
    @State private var navigate = false
    
    var body: some View {
        NavigationStack {
            VStack{
                Image(.food).resizable().frame(width : 340 ,height: 200)
                TextField("아이디 입력", text: $emailLoginViewModel.email).modifier(CustomTextFieldModifier())
                    .padding(.horizontal, 24)
                    .padding(.top , 12)
                
                if isSecure {
                    ZStack(alignment : .trailing) {
                        SecureField("비밀번호 입력", text: $emailLoginViewModel.password)
                            .modifier(CustomTextFieldModifier())
                                .padding(.vertical, 10)
                                .padding(.horizontal, 24)
                        Button {
                            isSecure.toggle()
                        } label: {
                            Image(.eyeClose).resizable().frame(width: 25, height: 25).padding(.horizontal, 40)
                            
                        }
                    }
                 
                } else {
                    ZStack(alignment : .trailing){
                        TextField("비밀번호 입력", text: $emailLoginViewModel.password).modifier(CustomTextFieldModifier())
                            .padding(.vertical, 10)
                            .padding(.horizontal, 24)
                        Button {
                            isSecure.toggle()
                        } label: {
                            Image(.eyeOpen).resizable().frame(width: 25, height: 25)
                                .padding(.horizontal, 40)
                            
                        }
                    }
                   
                }
                
                
                
                NavigationLink(destination: ContentView() , isActive: $navigate) {
                    Button(action: {
                        UserService.shared.login(parameters: ["email": emailLoginViewModel.email, "password" : emailLoginViewModel.password], success: { (data) in
                           
                            print("data : " , data)
                            // Hidden NavigationLink that becomes active based on the state
                           
                            // NavigationLink activated by the state variable
                            self.navigate = true
                            
                        }, failure: { (error) in
                            withAnimation {
                                toastManager.displayToast(
                                    message: error.message,
                                    duration: 3.0
                                )
                            }
                        })
                        
                    }, label: {
                        Text("로그인")
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background {
                            Color.primary7
                        }
                        .foregroundColor(.white)
                        .background()
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                        .bold()
                        
                    })
                }
                

                
                Spacer()
                
                // Toast
                if toastManager.isShowing {
                    toastManager.showToast()
                    .padding(.bottom, 50) // Toast의 위치 조정
                    .zIndex(1) // Toast를 최상위에 위치하도록 설정
                }
            }
            .environmentObject(toastManager)
            .padding(.top, 24)
            

        }
        
        
    }
}



#Preview {
    EmailLoginView()
}




