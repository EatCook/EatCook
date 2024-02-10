//
//  CustomTextField.swift
//  EatCook
//
//  Created by 김하은 on 2/10/24.
//

import SwiftUI

struct CustomTextField: View {
    var placeHolder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeHolder, text: $text)
            .padding(EdgeInsets(top: 0, leading: 14, bottom: 0, trailing: 14))
            .frame(height: 55)
            .background(Color.white)
            .cornerRadius(10)
    }
}
