//
//  ChipLayout.swift
//  EatCook
//
//  Created by 이명진 on 4/28/24.
//

import SwiftUI

struct ChipLayout: Layout {
    var verticalSpacing: CGFloat = 0
    var horizontalSpacing: CGFloat = 0
    
    struct Cache {
        var height: CGFloat = 0
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) -> CGSize {
        var sumX: CGFloat = 0
        var sumY: CGFloat = 0
        var currentLineHeight: CGFloat = 0
        
        for subview in subviews {
            let subviewSize = subview.sizeThatFits(.unspecified)
            if sumX + subviewSize.width > (proposal.width ?? 0) {
                sumX = 0
                sumY += currentLineHeight + verticalSpacing
                currentLineHeight = 0
            }
            sumX += subviewSize.width + horizontalSpacing
            currentLineHeight = max(currentLineHeight, subviewSize.height)
        }
        
        sumY += currentLineHeight
        
        cache.height = sumY
        return CGSize(width: proposal.width ?? 0, height: sumY)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) {
        var sumX: CGFloat = bounds.minX
        var sumY: CGFloat = bounds.minY
        var currentLineHeight: CGFloat = 0
        
        for subview in subviews {
            let subviewSize = subview.sizeThatFits(.unspecified)
            
            if sumX + subviewSize.width > bounds.width {
                sumX = bounds.minX
                sumY += currentLineHeight + verticalSpacing
                currentLineHeight = 0
            }
            
            subview.place(at: CGPoint(x: sumX, y: sumY), anchor: .topLeading, proposal: ProposedViewSize(subviewSize))
            sumX += subviewSize.width + horizontalSpacing
            currentLineHeight = max(currentLineHeight, subviewSize.height)
        }
    }
    
    func makeCache(subviews: Subviews) -> Cache {
        return Cache()
    }
    
    func updateCache(_ cache: inout Cache, subviews: Subviews) {}
}
//struct ChipLayout: Layout {
//    var verticalSpacing: CGFloat = 0
//    var horizontalSpacing: CGFloat = 0
//    
//    // scrollView에서 height = nil
//    // ✅ 변경된 부분 cache
//    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) -> CGSize {
//        print("--sizeThatFits--", cache)
//        // ✅ 추가된 부분
//        return CGSize(width: proposal.width ?? 0, height: cache.height)
//    }
//    
//    // proposal 제공 뷰크기
//    // bounds 위치
//    // ✅ 변경된 부분 cache
//    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) {
//        print("--placeSubviews--")
//        print("bound: ", bounds)
//        print("proposal: ", proposal)
//        
//        var sumX: CGFloat = bounds.minX
//        var sumY: CGFloat = bounds.minY
//        
//        for index in subviews.indices {
//            let view = subviews[index]
//            let viewSize = view.sizeThatFits(.unspecified)
//            guard let proposalWidth = proposal.width else { continue }
//            
//            // 가로 끝인경우 아래로 이동
//            if (sumX + viewSize.width > proposalWidth) {
//                sumX = bounds.minX
//                sumY += viewSize.height
//                sumY += verticalSpacing
//            }
//            
//            let point = CGPoint(x: sumX, y: sumY)
//            // anchor: point의 기준 적용지점
//            // proposal: unspecified, infinity -> 넘어감, zero -> 사라짐, size -> 제안한크기 만큼 지정됨
//            view.place(at: point, anchor: .topLeading, proposal: proposal)
//            sumX += viewSize.width
//            sumX += horizontalSpacing
//            
//            
//        }
//        // ✅ 추가된 부분
//        if let firstViewSize = subviews.first?.sizeThatFits(.unspecified) {
//            // sumY는 topLeading 기준의 좌표이므로 height를 구하려면
//            // chip뷰의 height를 더해야 전체 높이값이 나옵니다.
//            cache.height = sumY + firstViewSize.height
//        }
//    }
//    
//    // ✅ 추가된 부분
//    struct Cache {
//        var height: CGFloat
//    }
//    
//    func makeCache(subviews: Subviews) -> Cache {
//        print("make cache")
//        return Cache(height: 0)
//    }
//    
//    func updateCache(_ cache: inout Cache, subviews: Subviews) {
//        print("update cache", cache)
//    }
//}
