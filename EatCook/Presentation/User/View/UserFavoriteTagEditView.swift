//
//  UserFavoriteTagEditView.swift
//  EatCook
//
//  Created by 이명진 on 4/27/24.
//

import SwiftUI


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
            VStack(alignment: .leading, spacing: 8) {
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
            
            VStack(alignment: .leading, spacing: 8) {
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
        .navigationTitle("관심 요리 편집")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
}

#Preview {
//    NavigationStack {
        UserFavoriteTagEditView()
//    }
}
