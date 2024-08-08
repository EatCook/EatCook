//
//  CustomTextFieldModifier.swift
//  EatCook
//
//  Created by 김하은 on 2/10/24.
//

import SwiftUI

struct CustomTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        .padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 14))
        .frame(height: 55)
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.bdBorder, lineWidth:1)
        )
    }
}
