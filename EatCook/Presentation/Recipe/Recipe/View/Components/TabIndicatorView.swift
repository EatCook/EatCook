//
//  TabIndicatorView.swift
//  EatCook
//
//  Created by 이명진 on 2/17/24.
//

import SwiftUI

//struct TabIndicatorView: View {
//    @Binding var activeTab: RecipeTabCase
//    @Namespace private var animation
//    @State private var animationProgress: CGFloat = 0
//    
//    var scrollViewProxy: ScrollViewProxy
//    
//    var body: some View {
//        HStack {
//            ForEach(RecipeTabCase.allCases, id: \.self) { tabCase in
//                Text(tabCase.title)
//                    .font(.system(size: 16, weight: .semibold))
//                    .foregroundStyle(.gray8)
//                    .padding(.vertical, 12)
//                    .background(alignment: .bottom) {
//                        if activeTab == tabCase {
//                            RoundedRectangle(cornerRadius: 8)
//                                .fill()
//                                .frame(height: 3)
//                                .padding(.horizontal, -10)
////                                .offset(y: 15)
//                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
//                        }
//                    }
//                    .padding(.horizontal, 25)
//                    .contentShape(Rectangle())
//                    .id(tabCase.tabID)
//                    .onTapGesture {
//                        withAnimation(.easeInOut(duration: 0.3)) {
//                            activeTab = tabCase
//                            animationProgress = 1.0
//                            scrollViewProxy.scrollTo(tabCase, anchor: .topLeading)
//                        }
//                    }
//                
//            }
//        }
//        .onChange(of: activeTab) { newValue in
//            withAnimation(.easeInOut(duration: 0.3)) {
//                scrollViewProxy.scrollTo(newValue.tabID, anchor: .center)
//            }
//        }
//        .checkAnimationEnd(for: animationProgress) {
//            animationProgress = 0.0
//        }
//        .frame(maxWidth: .infinity)
//        .background(alignment: .bottom) {
//            Rectangle()
//                .fill(.gray2)
//                .frame(height: 1)
//        }
//    }
//}
//
//#Preview {
//    RecipeView()
//}
