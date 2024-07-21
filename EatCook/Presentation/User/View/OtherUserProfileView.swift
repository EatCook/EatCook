//
//  OtherUserProfileView.swift
//  EatCook
//
//  Created by 이명진 on 7/21/24.
//

import SwiftUI

struct OtherUserProfileView: View {
    @State private var isFollowed: Bool = false
    
    var body: some View {
        ScrollView {
            OtherUserProfileTopView(isFollowed: $isFollowed)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("레시피")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                
                ForEach(1..<20) { index in
                    UserProfileRowView()
                }
                
            }
            .padding(.top, 32)
            .padding(.bottom, 60)
        }
    }
}

#Preview {
    OtherUserProfileView()
}
