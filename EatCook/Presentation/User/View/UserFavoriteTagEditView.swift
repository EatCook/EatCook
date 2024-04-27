//
//  UserFavoriteTagEditView.swift
//  EatCook
//
//  Created by 이명진 on 4/27/24.
//

import SwiftUI

struct ChipLayout: Layout {
    var verticalSpacing: CGFloat = 0
    var horizontalSpacing: CGFloat = 0
    
    // scrollView에서 height = nil
    // ✅ 변경된 부분 cache
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) -> CGSize {
        print("--sizeThatFits--", cache)
        // ✅ 추가된 부분
        return CGSize(width: proposal.width ?? 0, height: cache.height)
    }
    
    // proposal 제공 뷰크기
    // bounds 위치
    // ✅ 변경된 부분 cache
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) {
        print("--placeSubviews--")
        print("bound: ", bounds)
        print("proposal: ", proposal)
        
        var sumX: CGFloat = bounds.minX
        var sumY: CGFloat = bounds.minY
        
        for index in subviews.indices {
            let view = subviews[index]
            let viewSize = view.sizeThatFits(.unspecified)
            guard let proposalWidth = proposal.width else { continue }
            
            // 가로 끝인경우 아래로 이동
            if (sumX + viewSize.width > proposalWidth) {
                sumX = bounds.minX
                sumY += viewSize.height
                sumY += verticalSpacing
            }
            
            let point = CGPoint(x: sumX, y: sumY)
            // anchor: point의 기준 적용지점
            // proposal: unspecified, infinity -> 넘어감, zero -> 사라짐, size -> 제안한크기 만큼 지정됨
            view.place(at: point, anchor: .topLeading, proposal: proposal)
            sumX += viewSize.width
            sumX += horizontalSpacing
            
            
        }
        // ✅ 추가된 부분
        if let firstViewSize = subviews.first?.sizeThatFits(.unspecified) {
            // sumY는 topLeading 기준의 좌표이므로 height를 구하려면
            // chip뷰의 height를 더해야 전체 높이값이 나옵니다.
            cache.height = sumY + firstViewSize.height
        }
    }
    
    // ✅ 추가된 부분
    struct Cache {
        var height: CGFloat
    }
    
    func makeCache(subviews: Subviews) -> Cache {
        print("make cache")
        return Cache(height: 0)
    }
    
    func updateCache(_ cache: inout Cache, subviews: Subviews) {
        print("update cache", cache)
    }
}

struct FavoriteFoodTag {
    var title: String
    var isSelected: Bool
    
    init(title: String, isSelected: Bool = false) {
        self.title = title
        self.isSelected = isSelected
    }
}

struct FoodThemeTag {
    var title: String
    var isSelected: Bool
    
    init(title: String, isSelected: Bool = false) {
        self.title = title
        self.isSelected = isSelected
    }
}

struct UserFavoriteTagEditView: View {
    @State private var sample1: [FavoriteFoodTag] = []
    @State private var sample2: [FoodThemeTag] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 4) {
                Text("관심요리")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.gray8)
                
                Text("최대 3개까지 선택 가능해요.")
                    .font(.system(size: 12))
                    .foregroundStyle(.gray6)
                
                ChipLayout(verticalSpacing: 16, horizontalSpacing: 8) {
                    ForEach(sample1.indices, id: \.self) { index in
                        let model = sample1[index]
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                sample1[index].isSelected.toggle()
                            }
                        } label: {
                            Text(model.title)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .font(.system(size: 14))
                            //                                .fontWeight(model.isSelected ? .semibold : .regular)
                                .foregroundStyle(model.isSelected ? .white : .gray6)
                                .background(
                                    RoundedRectangle(cornerRadius: 6)
                                        .foregroundStyle(model.isSelected ? .primary6 : .gray2)
                                )
                        }
                        
                    }
                }
                .padding(.vertical, 24)
                //                .border(.black)
            }
            
            VStack(alignment: .leading) {
                Text("나의 식생활 테마")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.gray8)
                
                Text("한 개만 선택 가능해요.")
                    .font(.system(size: 12))
                    .foregroundStyle(.gray6)
                
                ChipLayout(verticalSpacing: 16, horizontalSpacing: 8) {
                    ForEach(sample2.indices, id: \.self) { index in
                        let model = sample2[index]
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                sample2[index].isSelected.toggle()
                            }
                        } label: {
                            Text(model.title)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .font(.system(size: 14))
                            //                                .fontWeight(model.isSelected ? .semibold : .regular)
                                .foregroundStyle(model.isSelected ? .white : .gray6)
                                .background(
                                    RoundedRectangle(cornerRadius: 6)
                                        .foregroundStyle(model.isSelected ? .primary6 : .gray2)
                                )
                        }
                    }
                }
                .padding(.vertical, 24)
                //                .border(.black)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Text("완료")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(height: 52)
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.primary7)
                    }
            }
            .padding(.bottom)
        }
        .padding(.horizontal, 16)
        .padding(.top, 24)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                sample1 = [
                    FavoriteFoodTag(title: "반찬", isSelected: true),
                    FavoriteFoodTag(title: "일식"),
                    FavoriteFoodTag(title: "중식", isSelected: true),
                    FavoriteFoodTag(title: "한식", isSelected: true),
                    FavoriteFoodTag(title: "양식"),
                    FavoriteFoodTag(title: "디저트"),
                    FavoriteFoodTag(title: "아시안"),
                    FavoriteFoodTag(title: "야식"),
                    FavoriteFoodTag(title: "분식")
                ]
                
                sample2 = [
                    FoodThemeTag(title: "다이어트만 n년째"),
                    FoodThemeTag(title: "건강한 식단관리", isSelected: true),
                    FoodThemeTag(title: "밀키트 lover"),
                    FoodThemeTag(title: "편의점은 내 구역"),
                    FoodThemeTag(title: "배달음식 단골고객")
                ]
            }
        }
        
    }
    
}

#Preview {
    UserFavoriteTagEditView()
}
