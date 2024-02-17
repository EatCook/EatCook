//
//  TabIndicatorView.swift
//  EatCook
//
//  Created by 이명진 on 2/17/24.
//

import SwiftUI

struct TabIndicatorView: View {
    @Binding var activeTab: RecipeTabCase
    @Namespace private var animation
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let tabWidth = size.width / CGFloat(RecipeTabCase.allCases.count)
            
            HStack(spacing: 0) {
                ForEach(RecipeTabCase.allCases, id: \.self) { tabCase in
                    Text(tabCase.title)
                        .font(.headline)
                        .fontWeight(activeTab == tabCase ? .bold : .semibold)
                        .foregroundStyle(activeTab == tabCase ? Color.black : Color.gray)
                        .frame(width: tabWidth)
                        .background(alignment: .bottom) {
                            if activeTab == tabCase {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill()
                                    .frame(height: 3)
                                    .padding(.horizontal, 40)
                                    .offset(y: 15)
                                    .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                            }
                            
                            Divider()
                                .offset(y: 15)
                            
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation {
                                activeTab = tabCase
                            }
                        }
                }
            }
            .padding()
            .frame(width: CGFloat(RecipeTabCase.allCases.count) * tabWidth)
        }
        .frame(height: 50)
        .background(.white)
    }
}

#Preview {
    TabIndicatorView(activeTab: .constant(RecipeTabCase.recipe))
}
