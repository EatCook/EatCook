//
//  CustomImageTitleButton.swift
//  EatCook
//
//  Created by 이명진 on 4/23/24.
//

import SwiftUI

struct CustomImageTitleButton: View {
    var buttonTitle: String
    var buttonImage: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(buttonTitle)
                    .font(.system(size: 12))
                
                Image(systemName: buttonImage)
                    .frame(width: 14, height: 13)
            }
            .foregroundStyle(Color.gray4)
        }
    }
}

#Preview {
    CustomImageTitleButton(buttonTitle: "100", buttonImage: "heart.fill") {
        print("버튼 탭")
    }
}
