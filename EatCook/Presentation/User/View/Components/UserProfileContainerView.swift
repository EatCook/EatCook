//
//  UserProfileContainerView.swift
//  EatCook
//
//  Created by 이명진 on 7/21/24.
//

import SwiftUI

struct UserProfileContainerView: View {
    
    var tabCase: UserProfileTabCase = .mypage
    
    var body: some View {
        VStack {
//            switch tabCase {
//            case .mypage:
//                ForEach(1..<15, id: \.self) { index in
//                    UserProfileRowView()
//                }
//            case .storagebox:
//                UserProfileStorageView()
//            }
        }
    }
}

#Preview {
    UserProfileContainerView()
}
