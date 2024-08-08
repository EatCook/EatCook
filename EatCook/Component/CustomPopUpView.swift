//
//  CustomPopUpView.swift
//  EatCook
//
//  Created by 강신규 on 8/1/24.
//

import SwiftUI

struct CustomPopUpView: View {
    var title: String
    var message: String
    var confirmTitle : String
    var onConfirm: () -> Void

    var body: some View {
            VStack {
                VStack {
                    Image(.check)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.top, 40)
                        .padding(.bottom, 25)

                    Text(title)
                        .font(.title2).bold()
                        .padding(.bottom, 2)

                    Text(message)
                        .font(.callout)
                        .foregroundColor(.gray)

                    Spacer()

                    Button(action: {
                        onConfirm()
                    }) {
                        Text(confirmTitle)
                            .bold()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(.primary7)
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
        }

}


#Preview {
    CustomPopUpView(title: "제목", message: "메세지", confirmTitle: "버튼 텍스트", onConfirm: {
        print("closure 실행")
    })
}
