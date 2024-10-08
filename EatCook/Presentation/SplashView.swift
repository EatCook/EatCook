//
//  SplashView.swift
//  EatCook
//
//  Created by 김하은 on 2/6/24.
//

import SwiftUI

struct SplashView: View {
    
    var body: some View {
        VStack {
                Image(.splash)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
        }
    }
}

#Preview{
    SplashView()
}
