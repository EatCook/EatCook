//
//  FeedRowView.swift
//  EatCook
//
//  Created by 이명진 on 2/17/24.
//

import SwiftUI

struct FeedRowView: View {
    var body: some View {
        VStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray)
                .frame(height: 200)
            
            HStack {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 25, height: 25)
                
                Text("Username")
                    .font(.body)
                    .fontWeight(.semibold)
                
                Button {
                    
                } label: {
                    Text("팔로우")
                }
            }
            
            Text("오늘 냉장고 재료로 만든 요리는 바질 치킨 스테이크! 가뜩이나 약속도 없는데 집에서 혼자 배달시켜 먹을까 생각하다가, 크리스마스인 오늘 만큼은 나에게 대접하고 싶은 마음ㅎ_ㅎ 나도 크리스마스에 분위기 낼 수 있다구! 마침 집에 먹다 남은 치킨이 있길래, 치킨 남은거에 바질 사다가 바질 스테이크 해먹었다~")
                .font(.caption)
        }
        .padding(8)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)
        }
    }
}

#Preview {
    FeedRowView()
}
