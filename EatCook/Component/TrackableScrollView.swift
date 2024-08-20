//
//  TrackableScrollView.swift
//  EatCook
//
//  Created by 강신규 on 8/20/24.
//

import Foundation
import SwiftUI

struct TrackableScrollView<Header: View, Content: View>: View {
    @Binding var canShowHeader: Bool
    @State private var offset: CGFloat = 0
    
    let header: () -> Header
    let content: () -> Content
    let refreshable: () -> Void
    
    var body: some View {
        VStack {
            if canShowHeader {
                VStack {
                    header() // header content
                }
                .transition(
                    .asymmetric(
                        insertion: .push(from: .top),
                        removal: .push(from: .bottom)
                    )
                )
            }
            GeometryReader { outerGeo in
                let outerHeight = outerGeo.size.height
                
                ScrollView(.vertical, showsIndicators: false) {
                    content()
                        .background {
                            GeometryReader { innerGeo in
                                let contentHeight = innerGeo.size.height
                                let minY = innerGeo.frame(in: .named("ScrollView")).minY
                                let maxOffset = outerHeight - contentHeight
                                
                                Color.clear
                                    .onChange(of: minY) { newVal in
                                        if newVal >= 0 {
                                            // 상단 닿을때
                                            offset = newVal
                                            canShowHeader = true
                                        } else if newVal <= maxOffset {
                                            // 하단 닿을때
                                            canShowHeader = false
                                        } else if newVal < offset {
                                            // 스크롤 다운
                                            offset = newVal
                                            canShowHeader = false
                                        } else if newVal > offset {
                                            // 스크롤 업
                                            offset = newVal
                                            canShowHeader = true
                                        }
                                        
                               
                                    }
                            }
                        }
                }
                .refreshable {
                    refreshable()
                }
                .coordinateSpace(name: "ScrollView")
            }
            .padding(.top, 1)
        }
        .background(Color.white)
        .animation(.easeInOut(duration: 0.7), value: canShowHeader)
    }
}

struct TrackableOffsetModifier: ViewModifier {
    let onOffsetChange: (CGFloat) -> Void
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geo in
                    Color.clear
                        .preference(key: OffsetPreferenceKey.self, value: geo.frame(in: .named("ScrollView")).minY)
                }
            )
            .onPreferenceChange(OffsetPreferenceKey.self) { value in
                onOffsetChange(value)
            }
    }
}

struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
