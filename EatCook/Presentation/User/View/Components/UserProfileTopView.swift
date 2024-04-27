//
//  UserProfileTopView.swift
//  EatCook
//
//  Created by 이명진 on 4/7/24.
//

import SwiftUI

struct UserProfileTopView: View {
        var settingButtonAction: () -> Void
        var alramButtonAction: () -> Void
//    @EnvironmentObject private var naviPathFinder: NavigationPathFinder
    
    var body: some View {
        HStack(alignment: .center) {
            Text("마이페이지")
                .font(.title2)
                .bold()
            
            Spacer()
            
//            NavigationLink(destination: SettingView().toolbarRole(.editor)) {
//                Image(systemName: "gearshape.fill")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 21, height: 21)
//            }
//            .foregroundStyle(.primary)
            Button{
                settingButtonAction()
//                naviPathFinder.addPath(.setting)
            } label: {
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 21, height: 21)
            }
            
            Button{
                alramButtonAction()
            } label: {
                Image(systemName: "bell.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 21, height: 21)
            }
        }
        .frame(height: 130)
        .padding()
        .background(Color.gray3)
        
        
    }
}

#Preview {
    UserProfileTopView {
        
    } alramButtonAction: {
        
    }
//        .environmentObject(NavigationPathFinder.shared)
}
