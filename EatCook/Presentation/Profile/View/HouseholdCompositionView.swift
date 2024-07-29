//
//  HouseholdCompositionView.swift
//  EatCook
//
//  Created by 김하은 on 2/14/24.
//

import SwiftUI

struct HouseholdCompositionView: View {
    let columns = [GridItem(.flexible())]
    @State var isButtonEnabled = false
    
    var body: some View {
//        NavigationStack {
            VStack {
                Text("누구와 함께 살고있나요?")
                    .font(.title2)
                
                Text("나의 거주 형태에 맞는\n레시피를 만들어보아요.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .frame(height: 50)
                    .lineLimit(2)
                    .padding(.horizontal, 24)
                
                LazyVGrid(columns: columns, spacing: 14) {
                    ForEach(Household.themes, id: \.id) { data in
                        Button(action: {
                            
                        }, label: {
                            Text(data.title)
                                .font(.callout)
                                .foregroundColor(.gray)
                        })
                        .frame(height: 70)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.bdBorder, lineWidth:1)
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
            .background(.bgPrimary)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("회원가입")
//        }
    }
}

extension HouseholdCompositionView {
    struct Household {
        let id = UUID()
        let title: String
        
        static let themes: [Household] = [
            Household(title: "혼자 살아요"),
            Household(title: "부모님과 살아요"),
            Household(title: "친구와 살아요"),
            Household(title: "아이가 있어요"),
            Household(title: "남편/아내와 살아요"),
        ]
    }
}

#Preview {
    HouseholdCompositionView()
}
