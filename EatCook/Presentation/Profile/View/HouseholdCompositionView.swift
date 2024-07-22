//
//  HouseholdCompositionView.swift
//  EatCook
//
//  Created by 김하은 on 2/14/24.
//

import SwiftUI

struct HouseholdCompositionView: View {
    var email: String = ""
    var cookingType: [String] = []
    var userImage: UIImage?
    
    @StateObject private var householdCompositionViewModel = HouseholdCompositionViewModel()

    let columns = [GridItem(.flexible())]
    @State var isButtonEnabled = false
    @State private var selectedItem: String? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("주로 어떤 식사를 하나요?")
                    .bold()
                    .font(.title)
                
                Text("나의 생활 유형에 맞는\n레시피만 골라 볼 수 있어요.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .frame(height: 50)
                    .lineLimit(2)
                    .padding(.horizontal, 24)
                
                LazyVGrid(columns: columns, spacing: 14) {
                    ForEach(Household.themes, id: \.id) { data in
                        Button(action: {
                            self.selectedItem = data.title
                        }, label: {
                            Text(data.img)
                            Text(data.title)
                                .font(.callout)
                                .foregroundColor(.black)
                                .bold()
                        })
                        .frame(height: 70)
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(self.selectedItem == data.title ? Color.primary7 : Color.gray1, lineWidth:1)
                        )
                    }
                }.padding(.horizontal, 40)
                .padding(.top, 65)
                
                Spacer()
                
                NavigationLink(destination: HomeView().toolbarRole(.editor)) {
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
            .background(.gray1)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension HouseholdCompositionView {
    struct Household {
        let id = UUID()
        let img : String
        let title: String
        
        static let themes: [Household] = [
            Household(img: "🔥",  title: "다이어트만 n년째"),
            Household(img : "🥦" , title: "건강한 식단관리"),
            Household(img : "🍙" ,  title: "편의점은 내 구역"),
            Household(img : "🍕" , title: "배달음식 단골고객"),
            Household(img : "🍱" , title: " 밀키트 lover"),
        ]
    }
}

#Preview {
    HouseholdCompositionView()
}
