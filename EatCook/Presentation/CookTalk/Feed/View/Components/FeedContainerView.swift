//
//  FeedContainerView.swift
//  EatCook
//
//  Created by 이명진 on 2/17/24.
//

import SwiftUI

struct FeedContainerView: View {
    var body: some View {
        VStack(spacing: 16) {
            ForEach(1...7, id: \.self) { index in
                FeedRowView()
            }
        }
    }
}

#Preview {
    FeedView()
}
