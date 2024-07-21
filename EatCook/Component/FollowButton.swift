//
//  FollowButton.swift
//  EatCook
//
//  Created by 이명진 on 7/21/24.
//

import SwiftUI

struct FollowButton: View {
    @Binding var isFollowed: Bool
    var buttonAction: () -> ()
    
    var body: some View {
        Button {
            buttonAction()
        } label: {
            Text(isFollowed ? "팔로우 중" : "팔로우")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(isFollowed ? .gray5 : .white)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(isFollowed ? .gray3 : .primary7)
                }
        }
    }
}

#Preview {
    FollowButton(isFollowed: .constant(false)) {
        
    }
}
