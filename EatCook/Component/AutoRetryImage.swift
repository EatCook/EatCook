//
//  AutoRetryImage.swift
//  EatCook
//
//  Created by 이명진 on 8/7/24.
//

import SwiftUI

struct AutoRetryImage: View {
    
    @StateObject private var imageLoader = ImageLoadManager()
    let url: URL
    
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
                ProgressView()
            }
        }
    }
    
}

//#Preview {
//    AutoRetryImage()
//}
