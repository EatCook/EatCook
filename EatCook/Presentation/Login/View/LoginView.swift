//
//  LoginView.swift
//  EatCook
//
//  Created by 이명진 on 2/7/24.
//

import SwiftUI

struct LoginView: View {
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height / 2 - 80
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                HStack(spacing: 10) {
                    Image(.food1)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: width / 2 - 24, height: height)
                        .clipped()
                        .cornerRadius(10)
                    
                    VStack(spacing: 10) {
                        Image(.food2)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: width / 2 - 24, height: (height - 10) * 0.6)
                            .clipped()
                            .cornerRadius(10)
                        
                        Image(.food3)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: width / 2 - 24, height: (height - 10) * 0.4)
                            .clipped()
                            .cornerRadius(10)
                    }
                }
                
                Image(.whiteGradation)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 150)
                    .offset(y: 35)
                
                VStack {
                    Text("우리집 냉장고 파먹기")
                        .font(.title2)
                    Text("잇쿡")
                        .font(.largeTitle.bold())
                }.offset(y: 40)
            }.padding(.top, 40)
            
            Spacer()
            
            VStack(spacing: 12) {
                Button(action: {

                }, label: {
                    Image(.kakao)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
                .padding(.horizontal, 24)
                .frame(height: 55)
                
                Button(action: {

                }, label: {
                    Image(.apple)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                })
                .padding(.horizontal, 24)
                .frame(height: 55)
                
                NavigationLink(destination: EmailAuthView().toolbarRole(.editor)) {
                    Image(.email)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .padding(.horizontal, 24)
                .frame(height: 55)
            }.padding(.top)
            
            HStack(spacing: 10) {
                Button(action: {
                    
                }, label: {
                    Text("계정찾기")
                        .font(.body)
                        .foregroundStyle(.gray)
                })
                
                Divider()
                    .background(Color.gray)
                    .frame(height: 10)
                
                Button(action: {
                    
                }, label: {
                    Text("회원가입")
                        .font(.body)
                        .foregroundStyle(.gray)
                })
            }.padding(.vertical, 30)
        }
    }
}

#Preview {
    LoginView()
}
