//
//  FeedRowView.swift
//  EatCook
//
//  Created by 이명진 on 2/17/24.
//

import SwiftUI

struct FeedRowView: View {
    //    @Binding var isExpended: Bool
    @State private var isExpended: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 311, height: 196)
                .foregroundStyle(.gray4)
            
            HStack(spacing: 8) {
                Circle()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(.gray3)
                
                Text("나는쉐프다")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.gray9)
                
                Button {
                    
                } label: {
                    Text("팔로우")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.info4)
                }
            }
            
            HStack(alignment: .top, spacing: 8) {
                Text("오늘 냉장고 재료로 만든 요리는 바질 치킨 스테이크! 가뜩이나 약속도 없는데 집에서 혼자 배달시켜 먹을까 생각하다가, 크리스마스니까 오늘 냉장고 재료로 만든 요리는 바질 치킨 스테이크! 가뜩이나 약속도 없는데 집에서 혼자 배달시켜 먹을까 생각하다가, 크리스마스인 오늘 만큼은 나에게 대접하고 싶은 마음ㅎ_ㅎ 나도 크리스마스에 분위기 낼 수 있다구! 마침 집에 먹다 남은 치킨이 있길래, 치킨 남은거에 바질 사다가 바질 스테이크 해먹었다~")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.gray8)
                    .lineLimit(isExpended ? nil : 3)
                    .lineSpacing(4)
                    .frame(maxWidth: isExpended ? .infinity : .none)
                
                if !isExpended {
                    Button {
                        isExpended.toggle()
                    } label: {
                        Text("더 보기")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(.gray6)
                    }
                }
                
            }
            .padding(.horizontal, 22)
            .padding(.top, -10)
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 10, y: 5)
        }
    }
}

#Preview {
    FeedView()
}
