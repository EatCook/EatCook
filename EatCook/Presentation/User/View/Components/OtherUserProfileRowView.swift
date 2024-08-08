//
//  OtherUserProfileRowView.swift
//  EatCook
//
//  Created by 이명진 on 8/8/24.
//

import SwiftUI

struct OtherUserProfileRowView: View {
    var otherUserPageContentData = OtherUserPostsResponseList()
    
    var body: some View {
        HStack(spacing: 16) {
            if let imageUrl = URL(string: "\(Environment.AwsBaseURL)/\(otherUserPageContentData.postImagePath)") {
                AutoRetryImage(url: imageUrl, failImageType: .recipeStep)
                    .frame(width: 150, height: 110)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(otherUserPageContentData.recipeName)
                    .font(.system(size: 14, weight: .semibold))
                
                Text("????????????")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.gray6)
                    .lineLimit(2)
                    .padding(.bottom, 16)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    CustomImageTitleButton(buttonTitle: "\(otherUserPageContentData.likedCounts)", buttonImage: "heart.fill") {
                        print("HeartButton Tapped")
                    }
                }
                
                Spacer()
                
                Divider()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 110)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

#Preview {
    OtherUserProfileRowView()
}
