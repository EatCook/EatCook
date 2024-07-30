//
//  StartPopupView.swift
//  EatCook
//
//  Created by 김하은 on 2/12/24.
//

import SwiftUI

struct StartPopupView: View {
    var body: some View {
//        NavigationStack {
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
                    
                    NavigationLink(destination: CreateProfileView().toolbarRole(.editor)) {
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
//        }
    }
}

#Preview {
    StartPopupView()
}
