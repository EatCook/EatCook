//
//  LoadFailImageView.swift
//  EatCook
//
//  Created by 이명진 on 7/21/24.
//

import SwiftUI

struct LoadFailImageView: View {
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 8)
                .fill(.gray2)
                .frame(maxWidth: .infinity)
                .aspectRatio(4/3, contentMode: .fit)
            
            VStack(spacing: 8) {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 25, height: 20)
                    .foregroundStyle(.gray5)
                
                Text("이미지 다운로드에 실패했어요.")
                    .font(.system(size: 10, weight: .regular))
                    .foregroundStyle(.gray6)
            }
        }
    }
}

#Preview {
    LoadFailImageView()
}
