//
//  LifeTypePickerView.swift
//  EatCook
//
//  Created by 강신규 on 9/24/24.
//

import Foundation
import SwiftUI

struct LifeTypePickerView: View {
    @Binding var selectedLifeType : String
    let columns = [GridItem(.flexible())]
    
    var doneButtonAction: (String) -> ()
    var cancelButtonAction: () -> ()
    
    var body: some View {
        ScrollView {
            HStack {
                Text("요리 생활 타입을 선택해주세요")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(24)
            
            Spacer()
            
            LazyVGrid(columns: columns, spacing: 14) {
                ForEach(Household.themes, id: \.id) { data in
                    Button(action: {
                        selectedLifeType = data.title
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
                            .stroke(selectedLifeType == data.title ? Color.primary7 : Color.gray1, lineWidth:1)
                    )
                }
            }.padding(.horizontal, 40)
            
            Spacer()
            
            HStack {
                Button {
                    cancelButtonAction()
                } label: {
                    Text("취소")
                        .foregroundStyle(.gray5)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .modifier(CustomBorderModifier())
                
                Button {
                    doneButtonAction(selectedLifeType)
                } label: {
                    Text("선택")
                        .foregroundStyle(.white)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .modifier(CustomBorderModifier(background: .primary7))
            }
            .padding()
        }
        .background(.gray1)
    }
}

extension LifeTypePickerView {
    struct Household {
        let id = UUID()
        let img : String
        let title: String
        
        static let themes: [Household] = [
            Household(img: "🔥",  title: "다이어트만 n번째"),
            Household(img : "🥦" , title: "건강한 식단관리"),
            Household(img : "🍙" ,  title: "편의점은 내 구역"),
            Household(img : "🍕" , title: "배달음식 단골고객"),
            Household(img : "🍱" , title: "밀키트 lover"),
        ]
    }
}



