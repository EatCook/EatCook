//
//  CameraImageView.swift
//  EatCook
//
//  Created by 이명진 on 7/23/24.
//

import SwiftUI

struct CameraImageView: View {
    
    var body: some View {
        ZStack(alignment: .center) {
            Circle()
                .fill(.gray3)
                .frame(width: 42, height: 42)
            
            Image(systemName: "camera.fill")
                .resizable()
                .frame(width: 21, height: 16.5)
                .scaledToFit()
                .foregroundStyle(.gray5)
            
        }
        .frame(width: 42, height: 42)
    }
}

//#Preview {
//    CameraImageView()
//}
