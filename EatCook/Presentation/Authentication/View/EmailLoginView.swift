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
    
    
    var body: some View {
        NavigationStack {
            VStack{
                Image(.splash).resizable().frame(width : 340 ,height: 200)
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
                
                Button(action: {
                    
                    UserService.shared.login(parameters: ["email": emailLoginViewModel.email, "password" : emailLoginViewModel.password], success: { (data) in
                       
                        print("data : " , data)
                        // Hidden NavigationLink that becomes active based on the state
         
                        
                    }, failure: { (error) in
                        print(error)
                    })
                    
                }, label: {
                    Text("다음")
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background {
                        Color.primary7
                    }
                    .foregroundColor(.white)
                    .background()
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
                    
                })
//                .disabled(!emailValViewModel.authCodeValidation)
                
                Spacer()
            }.padding(.top, 24)

            
            
        }
        
        
    }
}

#Preview {
    EmailLoginView()
}
