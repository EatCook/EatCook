//
//  RecipeContainerView.swift
//  EatCook
//
//  Created by 이명진 on 2/17/24.
//

import SwiftUI

struct RecipeContainerView: View {
    var body: some View {
        VStack {
            ForEach(1...7, id: \.self) { index in
                RecipeContainerRowView(stepIndex: index)
            }
        }
        .padding()
    }
}

#Preview {
    RecipeContainerView()
}
