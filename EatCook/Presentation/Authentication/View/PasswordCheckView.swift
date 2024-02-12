//
//  PasswordCheckView.swift
//  EatCook
//
//  Created by 김하은 on 2/10/24.
//

import SwiftUI

struct PasswordCheckView: View {
    @State var password = ""
    @State var passwordCheck = ""
    @State var isButtonEnabled = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("비밀번호를 입력해 주세요")
                    .font(.title2)
                    .padding(.vertical, 28)

                CustomTextField(placeHolder: "비밀번호 입력 (영문+숫자 15자 이내) ", text: $password)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 24)

                CustomTextField(placeHolder: "비밀번호 확인", text: $passwordCheck)
                    .padding(.bottom, 14)
                    .padding(.horizontal, 24)
                
                Button(action: {

                }, label: {
                    Text("다음")
                })
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(isButtonEnabled ? Color.bdActive : Color.bdInactive)
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
    PasswordCheckView()
}
