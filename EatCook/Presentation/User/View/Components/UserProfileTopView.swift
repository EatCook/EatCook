//
//  UserProfileTopView.swift
//  EatCook
//
//  Created by 이명진 on 4/7/24.
//

import SwiftUI

struct UserProfileTopView: View {
    var body: some View {
        HStack(alignment: .center) {
            Text("마이페이지")
                .font(.title2)
                .bold()
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 21, height: 21)
            }
            
            Button {
                
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
    UserProfileTopView()
}
