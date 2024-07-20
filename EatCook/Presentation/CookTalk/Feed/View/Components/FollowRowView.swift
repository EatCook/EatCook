//
//  FollowRowView.swift
//  EatCook
//
//  Created by 이명진 on 7/19/24.
//

import SwiftUI

struct FollowRowView: View {
    @State private var isExpended: Bool = false
    @EnvironmentObject private var naviPathFinder: NavigationPathFinder
    var cookTalkFollowData: CookTalkFollowResponseList
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let imageUrl = URL(string: "\(Environment.AwsBaseURL)/\(cookTalkFollowData.postImagePath)") {
                ZStack(alignment: .bottomTrailing) {
                    AsyncImage(url: imageUrl) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 196)
//                                .aspectRatio(contentMode: .fit)
                        case .success(let image):
                            image
                                .resizable()
                                .frame(height: 196)
//                                .frame(maxWidth: .infinity)
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .frame(height: 196)
                                .frame(maxWidth: .infinity)
                                .aspectRatio(contentMode: .fit)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    HStack(spacing: 4) {
                        Text("\(cookTalkFollowData.likeCount)")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.white)
                        
                        Image(systemName: cookTalkFollowData.followCheck ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .scaledToFit()
                            .foregroundStyle(cookTalkFollowData.followCheck ? Color.red : Color.white)
                    }
                    .padding(.trailing, 12)
                    .padding(.bottom, 12)
                }
                .frame(maxWidth: .infinity)
                
            }
//            RoundedRectangle(cornerRadius: 10)
//                .frame(width: 311, height: 196)
//                .foregroundStyle(.gray4)
            
            HStack(spacing: 8) {
                Circle()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(.gray3)
                
                Text(cookTalkFollowData.nickName)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.gray9)
                
                Button {
                    
                } label: {
                    Text("팔로우")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.info4)
                }
            }
            
            HStack(alignment: .top, spacing: 8) {
                Text(cookTalkFollowData.introduction)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.gray8)
                    .lineLimit(isExpended ? nil : 3)
                    .lineSpacing(4)
                    .multilineTextAlignment(.leading)
                
                if !isExpended {
                    Button {
                        isExpended.toggle()
                    } label: {
                        Text("더 보기")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.gray6)
                    }
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 28)
            .padding(.top, -10)
            
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 10, y: 5)
        }
        .onTapGesture {
            naviPathFinder.addPath(.recipeDetail(cookTalkFollowData.postID))
        }
    }
}

#Preview {
    FeedView()
}
