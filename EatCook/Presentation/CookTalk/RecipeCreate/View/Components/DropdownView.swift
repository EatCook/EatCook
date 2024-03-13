//
//  DropdownView.swift
//  EatCook
//
//  Created by 이명진 on 3/2/24.
//

import SwiftUI

struct DropdownView: View {
    @Binding var showDropDown: Bool
    @Binding var selectedTheme: String
    var menu = ["한식", "일식", "양식", "중식", "아시아식", "분식", "야식"]
    
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                ZStack {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(menu, id: \.self) { menu in
                                Button {
                                    withAnimation {
                                        selectedTheme = menu
                                        showDropDown.toggle()
                                    }
                                } label: {
                                    Text(menu)
                                        .font(.caption)
                                        .foregroundStyle(.black)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 15)
                    }
                }
                .modifier(CustomBorderModifier())
                .frame(height: showDropDown ? 200 : 50)
                .offset(y: showDropDown ? 55 : 0)
                .foregroundStyle(.white)
                .shadow(radius: showDropDown ? 2 : 0)
                
                
                ZStack {
                    HStack {
                        Image(systemName: "fork.knife.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(selectedTheme == "테마 선택" ? .gray4 : .primary3)
                            .fontWeight(.bold)
                            .frame(width: 13.5)
                        
                        Text(selectedTheme)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(selectedTheme == "테마 선택" ? .gray5 : .primary7)
                            .frame(width: 60)
                        
                    }
                    .bold()
                    .padding()
                    .foregroundStyle(.primary7)
                }
                .frame(maxWidth: .infinity)
                .modifier(CustomBorderModifier())
                //                .offset(y: showDropDown ? -133 : 0)
                .onTapGesture {
                    withAnimation {
                        showDropDown.toggle()
                    }
                }
            }
            
            Spacer()
        }
//        .frame(height: 260)
        .frame(maxHeight: .infinity)
//        .offset(y: 40)
    }
}


#Preview {
    DropdownView(showDropDown: .constant(true), selectedTheme: .constant("한식"))
}
