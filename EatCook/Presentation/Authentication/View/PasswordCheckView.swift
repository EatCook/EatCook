//
//  PasswordCheckView.swift
//  EatCook
//
//  Created by 김하은 on 2/10/24.
//

import SwiftUI

struct PasswordCheckView: View {
    @State private var isPresented = false
    let email : String
    @State var isPasswordError = false
    @State private var isSecure = false
    
    @StateObject private var passwordCheckViewModel = PasswordChcekViewModel()
    @EnvironmentObject private var naviPathFinder: NavigationPathFinder
    
    var body: some View {
//        NavigationStack {
            VStack {
                Text("비밀번호를 입력해 주세요")
                    .font(.title2)
                    .padding(.vertical, 28)
                
                if isSecure {
                    ZStack(alignment : .trailing) {
                        SecureField("비밀번호 입력 (영문+숫자 15자 이내)", text: $passwordCheckViewModel.password)
                            .modifier(CustomTextFieldModifier())
                                .padding(.vertical, 14)
                                .padding(.horizontal, 24)
                        Button {
                            isSecure.toggle()
                        } label: {
                            Image(.eyeClose).resizable().frame(width: 25, height: 25).padding(.horizontal, 40)
                            
                        }
                    }
                 
                } else {
                    ZStack(alignment : .trailing){
                        TextField("비밀번호 입력 (영문+숫자 15자 이내)", text: $passwordCheckViewModel.password).modifier(CustomTextFieldModifier())
                            .padding(.vertical, 14)
                            .padding(.horizontal, 24)
                        Button {
                            isSecure.toggle()
                        } label: {
                            Image(.eyeOpen).resizable().frame(width: 25, height: 25)
                                .padding(.horizontal, 40)
                            
                        }
                    }
                   
                }
                  
                
                HStack(spacing : 10) {
                    HStack {
                        Image(passwordCheckViewModel.isLengthValid ? .checkTwoOn : .checkTwoOff)
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("8자리 이상")
                            .font(.system(size: 14))
                            .foregroundColor(passwordCheckViewModel.isLengthValid ? .success4 : .gray5)
                    }
                    HStack {
                        Image(passwordCheckViewModel.containsLetter ? .checkTwoOn : .checkTwoOff)
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("영문 포함")
                            .font(.system(size: 14))
                            .foregroundColor(passwordCheckViewModel.containsLetter ? .success4 :  .gray5)
                    }
                    HStack {
                        Image(passwordCheckViewModel.containsLetter ? .checkTwoOn : .checkTwoOff)
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("숫자 포함")
                            .font(.system(size: 14))
                            .foregroundColor(passwordCheckViewModel.containsNumber ? .success4 :  .gray5)
                    }

                    Spacer()
                    
                }.padding(.horizontal, 30)
                
                
            
                TextField("비밀번호 확인", text: $passwordCheckViewModel.passwordCheck).modifier(CustomTextFieldModifier())
                    .padding(.bottom, 14)
                    .padding(.horizontal, 24)
                
                if isPasswordError {
                    HStack() {
                        Image(.error).resizable().frame(width : 20, height: 20)
                        Text("비밀번호가 일치하지 않습니다").font(.system(size : 14)).font(.callout).foregroundColor(.error4)
                        Spacer()
                    }.padding(.horizontal, 24)
                }
                
   

                Button(action: {
                    
                    guard passwordCheckViewModel.passwordValidationCheck() else {
                        print("비밀번호 불일치 처리")
                        isPasswordError = true
                        return
                    }
                    
                    UserService.shared.passwordCheck(parameters: ["email": email, "password" : passwordCheckViewModel.password], success: { (data) in
                       
                        print("data : " , data)
                        
                        //    성공시
                        isPresented = true
                        
                        
         
                        
                    }, failure: { (error) in

                    })
                    
                    

                    
                }, label: {
                    Text("다음")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(passwordCheckViewModel.isValidPassword && passwordCheckViewModel.password.count == passwordCheckViewModel.passwordCheck.count ? Color.primary7 : Color.bdInactive)
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                }).fullScreenCover(isPresented: $isPresented) {
                    VStack {
                        VStack {
                            Image(.check)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding(.top, 40)
                                .padding(.bottom, 25)
                            
                            Text("회원가입 완료")
                                .font(.title2).bold()
                                .padding(.bottom, 2)
                            
                            Text("내 냉장고 속 재료들로 요리를 하러 가볼까요?")
                                .font(.callout)
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            Button {
        //                        createProfileView
//                                naviPathFinder.addPath()
                            } label: {
                                Text("시작하기")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 55)
                                    .background(Color.bdActive)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 24)
                            }


                            Spacer()
                        }.background(.white)
                            .cornerRadius(10)
                            .clipped()
                            .frame(maxHeight: 285)
                            .padding(.horizontal, 24)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3))
                }
                
                Spacer()
            }
            .padding(.top, 30)
        
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.bgPrimary)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("회원가입").bold()
//        }
    }
}

#Preview {
    PasswordCheckView(email: "").environmentObject(NavigationPathFinder.shared)
}

