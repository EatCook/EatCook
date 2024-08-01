//
//  CustomAlertView.swift
//  EatCook
//
//  Created by 강신규 on 8/1/24.
//

import SwiftUI

enum LayoutMode {
    case vertical
    case horizontal
}

struct CustomAlertView: View {
    var title: String
    var message: String
    var layoutMode: LayoutMode
    var leftTitle : String
    var rightTitle : String
    var onCancel: () -> Void
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
            
            
            if layoutMode == .vertical {
                VStack(spacing: 20) {
                    alertButtons
                }
                .padding([.leading, .trailing], 20)
            } else {
                HStack(spacing: 20) {
                    alertButtons
                }
                .padding([.leading, .trailing], 20)
            }
            

        }
        .frame(width: 300)
        .padding(.vertical , 24)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
    
    
    private var alertButtons: some View {
         Group {
             Button(action: {
                 onCancel()
             }) {
                 Text(leftTitle)
                     .bold()
                     .foregroundColor(.primary6)
                     .frame(maxWidth: .infinity)
                     .padding()
                     .background(.primary1)
                     .cornerRadius(8)
             }

             Button(action: {
                 onConfirm()
             }) {
                 Text(rightTitle)
                     .bold()
                     .foregroundColor(.white)
                     .frame(maxWidth: .infinity)
                     .padding()
                     .background(.primary7)
                     .cornerRadius(8)
             }
         }
     }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertView(
            title: "작성중인 글이있어요!",
            message: "임시 저장된 텍스트가 있어요",
            layoutMode: .horizontal,
            leftTitle: "새로 쓰기",
            rightTitle: "이어서 쓰기",
            onCancel: {
                print("새로 쓰기")
            },
            onConfirm: {
                print("이어서 쓰기")
            }
        )
    }
}
