//
//  UserProfileEditView.swift
//  EatCook
//
//  Created by 이명진 on 4/23/24.
//

import SwiftUI

struct UserProfileEditView: View {
    @State private var nickNameText: String = "요리만렙고수"
    @State private var emailText: String = "masterchef@gmail.com"
    @State private var passwordText: String = "12312344"
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            Rectangle()
                .frame(height: 160)
                .foregroundStyle(.white)
            
            ZStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Spacer()
                        .frame(height: 140)
                    
                    Text("닉네임")
                        .font(.system(size: 14))
                        .foregroundStyle(Color.gray8)
                        .padding(.bottom, 8)
                    
                    TextField("닉네임", text: $nickNameText)
                        .padding()
                        .modifier(CustomBorderModifier(cornerRadius: 10,
                                                       lineWidth: 1,
                                                       background: .white))
                    
                    Text("이메일")
                        .font(.system(size: 14))
                        .foregroundStyle(Color.gray8)
                        .padding(.bottom, 8)
                    
                    TextField("닉네임", text: $emailText)
                        .padding()
                        .modifier(CustomBorderModifier(cornerRadius: 10,
                                                       lineWidth: 1,
                                                       background: .white))
                    
                    Text("비밀번호")
                        .font(.system(size: 14))
                        .foregroundStyle(Color.gray8)
                        .padding(.bottom, 8)
                    
                    SecureField("닉네임", text: $passwordText)
                        .padding()
                        .modifier(CustomBorderModifier(cornerRadius: 10,
                                                       lineWidth: 1,
                                                       background: .white))
                    
                    HStack {
                        Spacer()
                        
                        Text("회원탈퇴")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.gray5)
                        
                        Divider()
                        
                        Text("로그아웃")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.gray5)
                        
                        Spacer()
                    }
                    .padding(24)
                    
                    Button {
                        
                    } label: {
                        Text("업데이트")
                            .font(.system(size: 16))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            
                    }
                    .frame(height: 56)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.primary7)
                    }
                    .padding(.top, 24)
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                
                
                ZStack(alignment: .bottomTrailing) {
                    Circle()
                        .frame(width: 130, height: 130)
                        .foregroundStyle(Color.gray3)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "pencil.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color.gray5)
                    }
                    .frame(width: 42, height: 42)
                    .background(.red)
                }
                .offset(y: -65)
                
                
                
            }
            
        }
        .background(Color.gray1)
        .ignoresSafeArea()
    }
}

#Preview {
    UserProfileEditView()
}
