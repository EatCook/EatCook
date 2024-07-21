//
//  OtherUserProfileTopView.swift
//  EatCook
//
//  Created by 이명진 on 7/21/24.
//

import SwiftUI

struct OtherUserProfileTopView: View {
    @Binding var isFollowed: Bool
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 10) {
                Circle()
                    .fill(.gray3)
                    .frame(width: 52, height: 52)
                
                VStack(alignment: .leading) {
                    Text("나는 쉐프다")
                        .font(.system(size: 18, weight: .semibold))
                    
                    BadgeTitleView(badgeLevel: BadgeTitleView.checkBadgeLevel(40))
                    
                    HStack(spacing: 4) {
                        Text("팔로우")
                            .font(.system(size: 14, weight: .regular))
                        
                        Text("399")
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.trailing, 8)
                        
                        Text("레시피")
                            .font(.system(size: 14, weight: .regular))
                        
                        Text("150")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .padding(.top, 8)
                }
                
                Spacer()
                
                FollowButton(isFollowed: $isFollowed) {
                    isFollowed.toggle()
                }
                
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 16)
            
            Divider()
                .foregroundStyle(.gray3)
        }
    }
}

#Preview {
    OtherUserProfileView()
}

