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
    
    var body: some View {
        NavigationStack {
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
                
                NavigationLink(destination: FoodThemeView(email: email, userImage: createProfileViewModel.userImage).toolbarRole(.editor)) {
                    Text("다음")
                        .bold()
                        .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(createProfileViewModel.isNickNameImageValid ? Color.primary6 : Color.bdInactive)
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
                }.disabled(!createProfileViewModel.isNickNameImageValid)
                
    
                
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
        }
    }
}

#Preview {
    CreateProfileView()
}
