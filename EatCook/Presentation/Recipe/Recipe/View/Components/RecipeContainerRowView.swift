//
//  RecipeContainerRowView.swift
//  EatCook
//
//  Created by 이명진 on 2/17/24.
//

import SwiftUI

struct RecipeContainerRowView: View {
    var stepIndex: Int
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Text("Step \(stepIndex)")
                .font(.headline)
                .fontWeight(.semibold)
            
            VStack {
                Text("닭을 분리해서 썬다.닭을 분리해서 썬다.닭을 분리해서 썬다.닭을 분리해서 썬다.닭을 분리해서 썬다.닭을 분리해서 썬다.닭을 분리해서 썬다.닭을 분리해서 썬다.")
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .lineLimit(5)
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(.gray.opacity(0.3))
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
            }
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    RecipeContainerRowView(stepIndex: 1)
}
