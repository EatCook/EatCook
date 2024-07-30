//
//  SplashView.swift
//  EatCook
//
//  Created by 김하은 on 2/6/24.
//

import SwiftUI

struct SplashView: View {
    @State private var isLaunching: Bool = true
        
    var body: some View {
        VStack {
            if isLaunching {
                Image(.splash)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation(.easeIn(duration: 0.7)) {
                               isLaunching = false
                           }
                        }
                    }
            } else {
                LoginView()
            }
        }
    }
}

#Preview{
    SplashView()
}
