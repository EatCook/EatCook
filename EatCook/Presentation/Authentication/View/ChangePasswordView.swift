//
//  ChangePasswordView.swift
//  EatCook
//
//  Created by 강신규 on 7/30/24.
//

import SwiftUI

struct ChangePasswordView: View {
        
    @EnvironmentObject private var naviPathFinder: NavigationPathFinder
    @StateObject private var changePasswordViewModel: ChangePasswordViewModel
    
    init(email: String) {
        _changePasswordViewModel = StateObject(wrappedValue: ChangePasswordViewModel(email: email , authUseCase:  AuthUseCase(eatCookRepository: EatCookRepository(networkProvider: NetworkProviderImpl(requestManager: NetworkManager())))))
    }
    @State private var shake = false
    
    
    
    
    var body: some View {
//        NavigationStack {
            VStack {
                
                Spacer()
                
                if changePasswordViewModel.newPasswordSecure {
                    ZStack(alignment : .trailing) {
                        SecureField("새 비밀번호 입력 (영문+숫자 15자 이내)", text: $changePasswordViewModel.newPassword)
                            .modifier(CustomTextFieldModifier())

                                .padding(.horizontal, 24)
                        Button {
                            changePasswordViewModel.newPasswordSecure.toggle()
                        } label: {
                            Image(.eyeClose).resizable().frame(width: 25, height: 25).padding(.horizontal, 40)
                            
                        }
                    }
                 
                } else {
                    ZStack(alignment : .trailing){
                        TextField("새 비밀번호 입력 (영문+숫자 15자 이내)", text: $changePasswordViewModel.newPassword).modifier(CustomTextFieldModifier())

                            .padding(.horizontal, 24)
                        Button {
                            changePasswordViewModel.newPasswordSecure.toggle()
                        } label: {
                            Image(.eyeOpen).resizable().frame(width: 25, height: 25)
                                .padding(.horizontal, 40)
                            
                        }
                    }
                   
                }
                
                
                if changePasswordViewModel.newPasswordCheckSecure {
                    ZStack(alignment : .trailing) {
                        SecureField("새 비밀번호 확인", text: $changePasswordViewModel.newPasswordCheck)
                            .modifier(CustomTextFieldModifier())
                                .padding(.vertical, 14)
                                .padding(.horizontal, 24)
                        Button {
                            changePasswordViewModel.newPasswordCheckSecure.toggle()
                        } label: {
                            Image(.eyeClose).resizable().frame(width: 25, height: 25).padding(.horizontal, 40)
                            
                        }
                    }
                 
                } else {
                    ZStack(alignment : .trailing){
                        TextField("새 비밀번호 확인", text: $changePasswordViewModel.newPasswordCheck).modifier(CustomTextFieldModifier())
                            .padding(.vertical, 14)
                            .padding(.horizontal, 24)
                        Button {
                            changePasswordViewModel.newPasswordCheckSecure.toggle()
                        } label: {
                            Image(.eyeOpen).resizable().frame(width: 25, height: 25)
                                .padding(.horizontal, 40)
                            
                        }
                    }
                   
                }
                
                if changePasswordViewModel.isPasswordError {
                    HStack() {
                        Image(.error).resizable().frame(width : 20, height: 20)
                        Text("비밀번호가 일치하지 않습니다").font(.system(size : 14)).font(.callout).foregroundColor(.error4)
                        Spacer()
                    }
                    .modifier(ShakeEffect(animatableData: CGFloat(shake ? 1 : 0)))
                    .padding(.horizontal, 24)
                }
                
                
                Spacer()
                
                
                
                Button(action: {
                    
                    guard changePasswordViewModel.passwordValidationCheck() else {
                        print("비밀번호 불일치 처리")
                        withAnimation {
                            changePasswordViewModel.isPasswordError = true
                            shake.toggle()
                        }
                        return
                    }
                    
                    changePasswordViewModel.changePassword { successResult in
                        if successResult {
//                            TODO : navigation First Page
                            naviPathFinder.addPath(.login)
                            print("비밀번호 변경 성공")
                            
                        }else {
//                            TODO : Alert 처리
                            print("비밀번호 변경 실패")
                        }
                    }
                              
                }, label: {
                    Text("다음")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(changePasswordViewModel.isValidPassword && changePasswordViewModel.newPassword.count == changePasswordViewModel.newPasswordCheck.count ? Color.primary7 : Color.bdInactive)
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                })
//                .fullScreenCover(isPresented: $isPresented) {
//                    StartPopupView()
//                }
                
                
                
                
     
                
            }.padding(.top, 30)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.bgPrimary)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("비밀번호 변경").bold()
            
            
            
        }
//    }
}

#Preview {
    ChangePasswordView(email: "previewEmail")
}
