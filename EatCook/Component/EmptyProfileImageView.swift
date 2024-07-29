//
//  EmptyProfileImageView.swift
//  EatCook
//
//  Created by 이명진 on 7/28/24.
//

import SwiftUI

struct EmptyProfileImageView: View {
    var body: some View {
        ZStack(alignment: .center) {
            Circle()
                .fill(.gray3)
                .frame(width: 25, height: 25)
            
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 19, height: 15)
                .scaledToFit()
                .foregroundStyle(.gray5)
            
        }
        .frame(width: 25, height: 25)
    }
}

#Preview {
    EmptyProfileImageView()
}
