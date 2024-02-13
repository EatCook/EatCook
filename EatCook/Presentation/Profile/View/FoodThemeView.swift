//
//  FoodThemeView.swift
//  EatCook
//
//  Created by 김하은 on 2/13/24.
//

import SwiftUI

struct FoodThemeView: View {
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    @State var isButtonEnabled = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("어떤 요리에 관심 있으신가요?")
                    .font(.title2)
                    .padding(.vertical)
                
                Text("관심있는 요리를 3가지 이상 선택해주세요\n취향에 맞는 레시피를 추천해드려요")
                    .font(.body)
                    .multilineTextAlignment(.center)
                
                LazyVGrid(columns: columns, spacing: 14) {
                    ForEach(FoodTheme.themes, id: \.id) { data in
                        Button(action: {
                            
                        }, label: {
                            data.image
                                .resizable()
                                .frame(width: 24, height: 24)
                            
                            Text(data.title)
                                .font(.callout)
                                .foregroundColor(.gray)
                        })
                        .frame(width: 90, height: 90)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.bdBorder, lineWidth:1)
                        )
                    }
                }.padding(.horizontal, 40)
                    .padding(.vertical, 65)
                
                Spacer()
                
                NavigationLink(destination: FoodThemeView().toolbarRole(.editor)) {
                    Text("다음")
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(isButtonEnabled ? Color.bdActive : Color.bdInactive)
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 46)
                }
            }
            .padding(.top, 30)
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.bgPrimary)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("회원가입")
        }
    }
}

extension FoodThemeView {
    struct FoodTheme {
        let id = UUID()
        let image: Image
        let title: String
        
        static let themes: [FoodTheme] = [
            FoodTheme(image: Image("food"), title: "양식"),
            FoodTheme(image: Image("food"), title: "한식"),
            FoodTheme(image: Image("food"), title: "아시아"),
            FoodTheme(image: Image(.food), title: "일식"),
            FoodTheme(image: Image(.food), title: "아무거나"),
            FoodTheme(image: Image(.food), title: "중식"),
            FoodTheme(image: Image(.food), title: "이유식"),
            FoodTheme(image: Image(.food), title: "저당식"),
            FoodTheme(image: Image(.food), title: "간식")
            
        ]
    }
}

#Preview {
    FoodThemeView()
}
