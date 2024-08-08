//
//  CustomBorderModifier.swift
//  EatCook
//
//  Created by 이명진 on 3/13/24.
//

import SwiftUI

struct CustomBorderModifier: ViewModifier {
    var isFocused: Bool
    var cornerRadius: CGFloat
    var lineWidth: CGFloat
    var background: Color
    
    init(
        isFocused: Bool = false,
        cornerRadius: CGFloat = 10,
        lineWidth: CGFloat = 1,
        background: Color = .white
    ) {
        self.isFocused = isFocused
        self.cornerRadius = cornerRadius
        self.lineWidth = lineWidth
        self.background = background
    }
    
    func body(content: Content) -> some View {
        content
            .background(background)
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(isFocused ? .primary4 : .gray3, lineWidth: lineWidth)
            }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}
