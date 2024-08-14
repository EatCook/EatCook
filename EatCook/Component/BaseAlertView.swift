//
//  BaseAlertView.swift
//  EatCook
//
//  Created by 강신규 on 8/14/24.
//

import Foundation
import SwiftUI


struct BaseAlertView: View {
    var title: String
    var message: String
    var confirmTitle : String
    var onConfirm: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.headline)
                .padding()
            
            Text(message)
                .font(.subheadline)
                .foregroundColor(.gray6)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 20)
            
            VStack(spacing: 20) {
                Button(action: {
                    onConfirm()
                }) {
                    Text(confirmTitle)
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.primary7)
                        .cornerRadius(8)
                }
            }
            .padding([.leading, .trailing], 20)
        }
        .frame(width: 300)
        .padding(.vertical , 24)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
    
    

}

struct BaseAlertView_Previews: PreviewProvider {
    static var previews: some View {
        BaseAlertView(
            title: "작성중인 글이있어요!",
            message: "임시 저장된 텍스트가 있어요",
            confirmTitle : "클릭",
            onConfirm: {
                print("이어서 쓰기")
            }
        )
    }
}

struct BaseAlertInfo {
    var title : String
    var message : String
}
