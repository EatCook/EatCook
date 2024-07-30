//
//  CreateProfileView.swift
//  EatCook
//
//  Created by 김하은 on 2/12/24.
//

import SwiftUI

struct CreateProfileView: View {
    @State var nickname = ""
    @State var isButtonEnabled = false
    
    var body: some View {
//        NavigationStack {
            VStack {
                Text("프로필을 설정해 주세요")
                    .font(.title2)
                    .padding(.vertical, 20)
                
                ZStack {
                    Image(.food)
                        .resizable()
                        .frame(width: 120, height: 120)
                        .cornerRadius(60)
                        .clipped()
                        
                    Button(action: {
                        
                    }, label: {
                        Image(.camera)
                            .resizable()
                            .frame(width: 46, height: 46)
                    }).offset(x: 45, y: 45)
                }
                
                TextField("2~6자의 한글의 닉네임 (기호 사용 불가)", text: $nickname).modifier(CustomTextFieldModifier())
                    .padding(.horizontal, 24)
                    .padding(.top, 36)
                    .padding(.bottom, 14)
                
                NavigationLink(destination: FoodThemeView().toolbarRole(.editor)) {
                    Text("다음")
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(isButtonEnabled ? Color.bdActive : Color.bdInactive)
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
                }
                
                Spacer()
            }
            .padding(.top, 30)
            
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
