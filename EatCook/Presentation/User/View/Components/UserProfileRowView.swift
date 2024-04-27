//
//  UserProfileRowView.swift
//  EatCook
//
//  Created by 이명진 on 4/23/24.
//

import SwiftUI

struct UserProfileRowView: View {
    var body: some View {
        HStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 154, height: 118)
                .foregroundStyle(Color.gray3)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("냉동새우 마늘 볶음")
                    .font(.system(size: 14, weight: .semibold))
                
                Text("간장을 끓이지않고 냉동새우로 간장새우장 만드는 법을 알려...")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.gray6)
                    .lineLimit(2)
                    .padding(.bottom, 16)
                
                HStack {
                    Spacer()
                    
                    CustomImageTitleButton(buttonTitle: "100", buttonImage: "heart.fill") {
                        print("HeartButton Tapped")
                    }
                    
                    CustomImageTitleButton(buttonTitle: "100", buttonImage: "bookmark.fill") {
                        print("BookmarkButton Tapped")
                    }
                }
                
                Divider()
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    UserProfileRowView()
}
