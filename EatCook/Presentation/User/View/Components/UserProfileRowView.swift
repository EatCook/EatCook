//
//  UserProfileRowView.swift
//  EatCook
//
//  Created by 이명진 on 4/23/24.
//

import SwiftUI

struct UserProfileRowView: View {
    var myPageContentData = MyPageMyRecipeContent()
    
    var body: some View {
        HStack(spacing: 16) {
            if let imageUrl = URL(string: "\(Environment.AwsBaseURL)/\(myPageContentData.postImagePath)") {
                AutoRetryImage(url: imageUrl)
                    .frame(width: 150, height: 110)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                AsyncImage(url: imageUrl) { phase in
//                    switch phase {
//                    case .empty:
//                        ProgressView()
//                    case .success(let image):
//                        image
//                            .resizable()
//                            .frame(width: 150, height: 110)
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                    case .failure:
//                        LoadFailImageView()
//                            .frame(width: 150, height: 110)
//                    @unknown default:
//                        EmptyView()
//                    }
//                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(myPageContentData.recipeName)
                    .font(.system(size: 14, weight: .semibold))
                
                Text(myPageContentData.introduction)
                    .font(.system(size: 14))
                    .foregroundStyle(Color.gray6)
                    .lineLimit(2)
                    .padding(.bottom, 16)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    CustomImageTitleButton(buttonTitle: "\(myPageContentData.likeCounts)", buttonImage: "heart.fill") {
                        print("HeartButton Tapped")
                    }
                    
                    CustomImageTitleButton(buttonTitle: "100", buttonImage: "bookmark.fill") {
                        print("BookmarkButton Tapped")
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
    UserProfileRowView()
}
