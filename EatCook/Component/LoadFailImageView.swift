//
//  LoadFailImageView.swift
//  EatCook
//
//  Created by 이명진 on 7/21/24.
//

import SwiftUI

struct LoadFailImageView: View {
    var imageType: LoadFailImageType
    
    var body: some View {
        switch imageType {
        case .recipeMain, .recipeStep, .archive, .myPageRecipe:
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.gray2)
                    .frame(maxWidth: .infinity)
                    .aspectRatio(4/3, contentMode: .fit)
                
                VStack(spacing: 8) {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 25, height: 20)
                        .foregroundStyle(.gray5)
                    
                    Text("이미지 다운로드에 실패했어요.")
                        .font(.system(size: 10, weight: .regular))
                        .foregroundStyle(.gray6)
                }
            }
        case .userProfileLarge:
            ZStack(alignment: .center) {
                Circle()
                    .fill(.gray2)
                    .frame(width: 96, height: 96)
                
                Image("person")
                    .resizable()
                    .frame(width: 74, height: 74)
            }
        case .userProfileMedium:
            ZStack(alignment: .center) {
                Circle()
                    .fill(.gray2)
                    .frame(width: 52, height: 52)
                
                Image("person")
                    .resizable()
                    .frame(width: 32, height: 32)
            }
        case .userProfileSmall:
            ZStack(alignment: .center) {
                ZStack(alignment: .center) {
                    Circle()
                        .fill(.gray2)
                        .frame(width: 25, height: 25)
                    
                    Image("person")
                        .resizable()
                        .frame(width: 16, height: 16)
                }
            }
        }
        
    }
}

#Preview {
    LoadFailImageView(imageType: .userProfileLarge)
}
