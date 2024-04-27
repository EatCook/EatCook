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
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Circle()
                        .frame(width: 130, height: 130)
                        .padding(.top, 24)
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
                
                VStack(alignment: .leading) {
                    
                    Text("닉네임")
                        .font(.system(size: 14))
                        .foregroundStyle(Color.gray6)
                        .padding(.bottom, 8)
                    
                    TextField("닉네임", text: $nickNameText)
                        .padding()
                        .modifier(CustomBorderModifier(cornerRadius: 10,
                                                       lineWidth: 1,
                                                       background: .white))
                        .padding(.bottom, 24)
                    
                    Text("이메일")
                        .font(.system(size: 14))
                        .foregroundStyle(Color.gray6)
                        .padding(.bottom, 8)
                    
                    TextField("이메일", text: $emailText)
                        .padding()
                        .foregroundStyle(.gray5)
                        .modifier(CustomBorderModifier(cornerRadius: 10,
                                                       lineWidth: 1,
                                                       background: .gray3))
                        .disabled(true)
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .padding(.top, 41)
                
                Rectangle()
                    .fill(.gray1)
                    .padding(.top, 48)
                
                Button {
                    
                } label: {
                    HStack {
                        Text("비밀번호 변경")
                            .font(.system(size: 16))
                            .foregroundStyle(.gray6)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 9, height: 16)
                            .foregroundStyle(.gray4)
                    }
                    .padding(.vertical, 19)
                    .padding(.horizontal, 16)
                }
                
                Button {
                    
                } label: {
                    HStack {
                        Text("회원탈퇴")
                            .font(.system(size: 16))
                            .foregroundStyle(.gray6)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 9, height: 16)
                            .foregroundStyle(.gray4)
                    }
                    .padding(.vertical, 19)
                    .padding(.horizontal, 16)
                }
                
                Button {
                    
                } label: {
                    HStack {
                        Text("로그아웃")
                            .font(.system(size: 16))
                            .foregroundStyle(.gray6)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 9, height: 16)
                            .foregroundStyle(.gray4)
                    }
                    .padding(.vertical, 19)
                    .padding(.horizontal, 16)
                }
                
                
            }
        }
        
//        .navigationBarItems(trailing:
//                            Button(action: {
//                                print("Right Button Tapped!")
//                            }) {
//                                Image(systemName: "plus")
//                            }
//                        )
        
    }
}

#Preview {
    UserProfileEditView()
}
