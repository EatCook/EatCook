//
//  EmailAuthView.swift
//  EatCook
//
//  Created by 김하은 on 2/10/24.
//

import SwiftUI

struct EmailAuthView: View {
    @State var email = ""
    @State var authNumber = ""
    @State var isAuthRequest = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("이메일을 인증해 주세요")
                    .font(.title2)
                    .padding(.vertical, 28)
                
                HStack {
                    TextField("이메일", text: $email)
                        .padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 14))
                        .frame(height: 55)
                        .background()
                        .cornerRadius(10)
                    
                    Button(action: {
                        
                    }, label: {
                        Text("인증요청")
                            .font(.callout)
                            .foregroundStyle(.white)
                    })
                    .frame(width: 80,height: 55)
                    .background(Color.bdActive)
                    .cornerRadius(10)
                }.padding(.vertical, 14)
                .padding(.horizontal, 24)
                
                HStack {
                    TextField("인증번호", text: $authNumber)
                        .padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 14))
                        .frame(height: 55)
                        .background()
                        .cornerRadius(10)
                    Button(action: {
                        
                    }, label: {
                        Text("3:00")
                    })
                    .frame(width: 80,height: 55)
                    .background(isAuthRequest ? Color.bdActive : Color.bdInactive)
                    .cornerRadius(10)
                }.padding(.bottom, 14)
                .padding(.horizontal, 24)
                
                Button(action: {

                }, label: {
                    Text("다음")
                })
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(isAuthRequest ? Color.bdActive : Color.bdInactive)
                .cornerRadius(10)
                .padding(.horizontal, 24)

                Spacer()
            }
            .padding(.top, 30)
        
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.bgPrimary)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("회원가입").bold()
        }
    }
}

#Preview {
    EmailAuthView()
}
