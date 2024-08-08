//
//  AutoRetryImage.swift
//  EatCook
//
//  Created by 이명진 on 8/7/24.
//

import SwiftUI


enum LoadFailImageType {
    case recipeMain
    case recipeStep
    case archive
    case myPageRecipe
    case userProfileLarge
    case userProfileMedium
    case userProfileSmall
    
    @ViewBuilder
    func loadFailImageView() -> some View {
        switch self {
        case .recipeMain, .recipeStep, .archive, .myPageRecipe: LoadFailImageView(imageType: .recipeMain)
        case .userProfileLarge: LoadFailImageView(imageType: .userProfileLarge)
        case.userProfileMedium: LoadFailImageView(imageType: .userProfileMedium)
        case .userProfileSmall: LoadFailImageView(imageType: .userProfileSmall)
        }
    }
}

struct AutoRetryImage: View {
    
    @StateObject private var imageLoader = ImageLoadManager()
    let url: URL
    var failImageType: LoadFailImageType
    
    var body: some View {
        content
            .onAppear {
                imageLoader.load(url: url)
            }
    }
    
    private var content: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                LoadFailImageView(imageType: failImageType)
            }
        }
    }
    
}

//#Preview {
//    AutoRetryImage()
//}
