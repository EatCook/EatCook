//
//  UserProfileTopView.swift
//  EatCook
//
//  Created by 이명진 on 4/7/24.
//

import SwiftUI

struct UserProfileTopView: View {
    var settingButtonAction: () -> Void
//    var alramButtonAction: () -> Void
    
    var body: some View {
        HStack(alignment: .center) {
            Text("마이페이지")
                .font(.title2)
                .bold()
                .foregroundStyle(.gray8)
            
            Spacer()
            
            Button{
                settingButtonAction()
            } label: {
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 21, height: 21)
                    .foregroundStyle(.gray5)
            }
            
//            Button{
//                alramButtonAction()
//            } label: {
//                Image(systemName: "bell.fill")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 21, height: 21)
//            }
        }
        .frame(height: 130)
        .padding()
        .background(Color.gray3)
        
        
    }
}

#Preview {
    UserProfileTopView {
        
    }
    //        .environmentObject(NavigationPathFinder.shared)
}
