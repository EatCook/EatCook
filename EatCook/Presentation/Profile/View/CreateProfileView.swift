//
//  CreateProfileView.swift
//  EatCook
//
//  Created by 김하은 on 2/12/24.
//

import SwiftUI

struct CreateProfileView: View {
//    회원가입 완료시 받아올 email
    var email: String = ""
    
    @StateObject private var createProfileViewModel = CreateProfileViewModel()
    @State private var showImagePicker = false
    @State private var navigateToFoodThemeView = false
    @State private var isNickNameError = false
    @State private var shake = false
    
    var body: some View {
//        NavigationStack {
            VStack {
                Text("프로필을 설정해 주세요")
                    .bold()
                    .font(.title2)
                    .padding(.vertical, 20)
    
                
                if let image = createProfileViewModel.userImage {
                    Button(action: {
                        self.showImagePicker = true
                    }, label: {
                        ZStack(alignment : .bottomTrailing) {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 140, height: 131)
                                .clipShape(Circle())
                            Image(.camera)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipped()
                        }
                    })
                }else{
                    Button(action: {
                        self.showImagePicker = true
                    }, label: {
                        Image(.createProfile)
                            .resizable()
                            .frame(width: 140, height: 131)
                            .clipped()
                    })
                }
    
                TextField("2~6자의 한글의 닉네임 (기호 사용 불가)", text: $createProfileViewModel.nickname).modifier(CustomTextFieldModifier())
                    .padding(.horizontal, 24)
                    .padding(.top, 36)
                    .padding(.bottom, 14)
                
                if isNickNameError {
                    HStack() {
                        Image(.error).resizable().frame(width : 20, height: 20)
                        Text("이미 존재하는 닉네임입니다").font(.system(size : 14)).font(.callout).foregroundColor(.error4)
                        Spacer()
                    }.padding(.horizontal, 24)
                    .modifier(ShakeEffect(animatableData: CGFloat(shake ? 1 : 0)))
                }

                Button(action: {
                    createProfileViewModel.checkNickName { result in
                        if result.success {
                            navigateToFoodThemeView = true
                            isNickNameError = false
                        }else{
                            withAnimation {
                                isNickNameError = true
                                shake.toggle()
                            }
                        }
                    }
                    
                }, label: {
                    Text("다음")
                        .bold()
                        .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(createProfileViewModel.isNickNameImageValid ? Color.primary6 : Color.bdInactive)
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
                }).disabled(!createProfileViewModel.isNickNameImageValid)
                
                
                NavigationLink(destination:  FoodThemeView(email: email, nickName : createProfileViewModel.nickname, userImage: createProfileViewModel.userImage).toolbarRole(.editor), isActive: $navigateToFoodThemeView) {
                    EmptyView()
                }
                
    
                
                Spacer()
            }
            .padding(.top, 30)
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: self.$createProfileViewModel.userImage)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.bgPrimary)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("회원가입")
//        }
    }
}

#Preview {
    CreateProfileView()
}


