//
//  LoadingImageView.swift
//  EatCook
//
//  Created by 이명진 on 8/5/24.
//

import SwiftUI

struct LoadingImageView: View {
    @State private var currentImageIndex = 0
    @State private var opacity: Double = 1.0
    private let images = ["loading1", "loading2", "loading3", "loading4", "loading5",
                          "loading6", "loading7", "loading8", "loading9", "loading10"]
    
    var body: some View {
        Image(images[currentImageIndex])
            .resizable()
            .scaledToFit()
            .opacity(opacity)
            .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
                withAnimation(.easeInOut(duration: 0.3)) {
                    opacity = 0.5
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    currentImageIndex = (currentImageIndex + 1) % images.count
                    withAnimation(.easeInOut(duration: 0.3)) {
                        opacity = 1.0
                    }
                }
            }
            .frame(width: 60, height: 60)
    }
}

#Preview {
    LoadingImageView()
}
