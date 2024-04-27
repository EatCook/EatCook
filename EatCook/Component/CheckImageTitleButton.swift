//
//  CheckImageTitleButton.swift
//  EatCook
//
//  Created by 이명진 on 4/27/24.
//

import SwiftUI

struct CheckImageTitleButton: View {
    @Binding var isSelected: Bool
    var buttonTitle: String
    var buttonImage: String
    var action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: action) {
                HStack(spacing: 12) {
                    Image(systemName: buttonImage)
                        .resizable()
                        .frame(width: 16.5, height: 13.5)
                        .foregroundStyle(isSelected ? .primary6 : .gray4)
                    
                    Text(buttonTitle)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.gray6)
                }
            }
            .padding(.vertical, 14)
            
            Divider()
        }
        .padding(.horizontal, 26)
        
    }
}

#Preview {
    CheckImageTitleButton(isSelected: .constant(true),
                          buttonTitle: "계정정보",
                          buttonImage: "checkmark") {
        print("Tapped")
    }
}
