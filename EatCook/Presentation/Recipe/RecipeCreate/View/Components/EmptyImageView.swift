//
//  EmptyImageView.swift
//  EatCook
//
//  Created by 이명진 on 2/17/24.
//

import SwiftUI

struct EmptyImageView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "camera")
                .resizable()
                .scaledToFit()
                .frame(width: 30)
                .foregroundStyle(.gray)
            
            Text("이미지 업로드")
                .font(.subheadline)
                .foregroundStyle(.gray)
        }
        .frame(height: 170)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(.gray.opacity(0.2))
        }
    }
}

#Preview {
    EmptyImageView()
}
